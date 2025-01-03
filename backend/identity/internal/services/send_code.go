package services

import (
	"context"
	"crypto/rand"
	"encoding/binary"
	"errors"
	"fmt"
	"time"

	"github.com/chakchat/chakchat/backend/identity/internal/userservice"
	"github.com/google/uuid"
)

var (
	ErrUserNotFound         = errors.New("user not found")
	ErrSendCodeFreqExceeded = errors.New("send code operation frequency exceeded")
)

var nowUTC = func() time.Time {
	return time.Now().UTC()
}

type SmsSender interface {
	SendSms(ctx context.Context, phone string, message string) error
}

type SignInMeta struct {
	SignInKey   uuid.UUID
	LastRequest time.Time
	Phone       string
	Code        string

	UserId   uuid.UUID
	Username string
}

type MetaFindStorer interface {
	FindMetaByPhone(ctx context.Context, phone string) (*SignInMeta, bool, error)
	Store(context.Context, *SignInMeta) error
}

type CodeConfig struct {
	SendFrequency time.Duration
}

type SendCodeService struct {
	config *CodeConfig

	sms     SmsSender
	storage MetaFindStorer
	users   userservice.UsersServiceClient
}

func NewSendCodeService(config *CodeConfig, sms SmsSender,
	storage MetaFindStorer, users userservice.UsersServiceClient) *SendCodeService {
	return &SendCodeService{
		config:  config,
		sms:     sms,
		storage: storage,
		users:   users,
	}
}

func (s *SendCodeService) SendCode(ctx context.Context, phone string) (signInKey uuid.UUID, err error) {
	if err := s.validateSendFreq(ctx, phone); err != nil {
		return uuid.Nil, err
	}

	meta := SignInMeta{
		SignInKey:   uuid.New(),
		LastRequest: nowUTC(),
	}

	var user *userservice.UserResponse
	if user, err = s.fetchUser(ctx, phone); err != nil {
		return uuid.Nil, err
	}

	meta.UserId = uuid.MustParse(user.UserId.GetValue())
	meta.Username = *user.UserName
	meta.Code = genCode()

	sms := renderCodeSMS(meta.Code)
	if err := s.sms.SendSms(ctx, phone, sms); err != nil {
		return uuid.Nil, fmt.Errorf("send SMS error: %s", err)
	}

	if err := s.storage.Store(ctx, &meta); err != nil {
		return uuid.Nil, fmt.Errorf("storage error: %s", err)
	}

	return meta.SignInKey, err
}

func (s *SendCodeService) validateSendFreq(ctx context.Context, phone string) error {
	prevMeta, ok, err := s.storage.FindMetaByPhone(ctx, phone)
	if err != nil {
		return fmt.Errorf("finding SignInMeta error: %s", err)
	}
	if ok && prevMeta.LastRequest.Add(s.config.SendFrequency).Compare(nowUTC()) > 0 {
		return ErrSendCodeFreqExceeded
	}
	return nil
}

func (s *SendCodeService) fetchUser(ctx context.Context, phone string) (*userservice.UserResponse, error) {
	user, err := s.users.GetUser(ctx, &userservice.UserRequest{
		PhoneNumber: phone,
	})

	if err != nil {
		return nil, fmt.Errorf("user gRPC call error: %s", err)
	}
	if user.Status != userservice.UserResponseStatus_SUCCESS {
		if user.Status == userservice.UserResponseStatus_FAILED {
			return nil, errors.New("unknown gRPC GetUser() error")
		}
		if user.Status == userservice.UserResponseStatus_NOT_FOUND {
			return nil, ErrUserNotFound
		}
		return nil, fmt.Errorf("unexpected user service status: %v", user.Status)
	}

	return user, nil
}

func renderCodeSMS(code string) string {
	return "Do not tell this code to anybody. Your code for chakchat signing in is " + code
}

func genCode() string {
	b := make([]byte, 4)
	if _, err := rand.Read(b); err != nil {
		// I'll pray it won't happen
		panic("failed to generate random code")
	}
	n := 1e5 + binary.BigEndian.Uint32(b)%9e5
	return fmt.Sprintf("%06d", n)
}
