package services

import (
	"context"
	"errors"
	"fmt"

	"github.com/chakchat/chakchat/backend/identity/internal/jwt"
)

var (
	ErrRefreshTokenExpired     = errors.New("refresh token expired")
	ErrRefreshTokenInvalidated = errors.New("refresh token invalidated")
	ErrInvalidJWT              = errors.New("jwt token is invalid")
)

type RefreshTokenChecker interface {
	Invalidated(context.Context, jwt.Token) (bool, error)
}

type RefreshService struct {
	accessConf  *jwt.Config
	refreshConf *jwt.Config

	checker RefreshTokenChecker
}

func NewRefreshService(checker RefreshTokenChecker, accessConf, refreshConf *jwt.Config) *RefreshService {
	return &RefreshService{
		accessConf:  accessConf,
		refreshConf: refreshConf,
		checker:     checker,
	}
}

func (s *RefreshService) Refresh(ctx context.Context, refresh jwt.Token) (jwt.Pair, error) {
	if err := s.validate(ctx, refresh); err != nil {
		return jwt.Pair{}, err
	}

	parsed, err := jwt.Parse(s.refreshConf, refresh)
	if err != nil {
		if err == jwt.ErrTokenExpired {
			return jwt.Pair{}, ErrRefreshTokenExpired
		}
		return jwt.Pair{}, ErrInvalidJWT
	}

	claims := extractPublic(parsed)
	var pair jwt.Pair
	if pair.Access, err = jwt.Generate(s.accessConf, claims); err != nil {
		return jwt.Pair{}, fmt.Errorf("access token generation failed: %s", err)
	}
	if pair.Refresh, err = jwt.Generate(s.refreshConf, claims); err != nil {
		return jwt.Pair{}, fmt.Errorf("refresh token generation failed: %s", err)
	}
	return pair, nil
}

func extractPublic(claims jwt.Claims) jwt.Claims {
	return jwt.Claims{
		jwt.ClaimSub:  claims[jwt.ClaimSub],
		jwt.ClaimName: claims[jwt.ClaimName],
	}
}

func (s *RefreshService) validate(ctx context.Context, refresh jwt.Token) error {
	invalidated, err := s.checker.Invalidated(ctx, refresh)
	if err != nil {
		return err
	}
	if invalidated {
		return ErrRefreshTokenInvalidated
	}
	return nil
}
