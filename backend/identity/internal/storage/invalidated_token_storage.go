package storage

import (
	"context"
	"fmt"
	"time"

	"github.com/chakchat/chakchat/backend/identity/internal/jwt"
	"github.com/redis/go-redis/v9"
)

const (
	preffixInvalidatedToken = "InvalidatedToken:"
	invalidatedVal          = "invalidated"
)

type InvalidatedTokenConfig struct {
	invalidatedExp time.Duration
}

type InvalidatedTokenStorage struct {
	client *redis.Client
	config *InvalidatedTokenConfig
}

func NewInvalidatedTokenStorage(config *InvalidatedTokenStorage, client *redis.Client) *InvalidatedTokenStorage {
	return &InvalidatedTokenStorage{
		client: client,
	}
}

func (s *InvalidatedTokenStorage) Invalidate(ctx context.Context, token jwt.Token) error {
	key := preffixInvalidatedToken + string(token)

	res := s.client.Set(ctx, key, invalidatedVal, s.config.invalidatedExp)
	if err := res.Err(); err != nil {
		return fmt.Errorf("redis set invalidated token failed: %s", err)
	}
	return nil
}

func (s *InvalidatedTokenStorage) Invalidated(ctx context.Context, token jwt.Token) (bool, error) {
	key := preffixInvalidatedToken + string(token)

	res := s.client.Get(ctx, key)
	if err := res.Err(); err != nil {
		if err == redis.Nil {
			return false, nil
		}
		return false, fmt.Errorf("redis get invalidated token failed: %s", err)
	}
	return true, nil
}
