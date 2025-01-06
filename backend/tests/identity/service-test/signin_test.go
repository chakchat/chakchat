package main_test

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http"
	"regexp"
	"test/common"
	"testing"

	"github.com/google/uuid"
	"github.com/stretchr/testify/require"
)

func Test_SignIn(t *testing.T) {
	phone := common.NewPhone(common.PhoneExisting)
	signInKey := requestSendPhoneCode(t, phone)
	code := getPhoneCode(t, phone)

	resp := doSignInRequest(t, signInKey, code, uuid.New())

	require.Equal(t, http.StatusOK, resp.StatusCode)
}

func doSignInRequest(t *testing.T, signInKey, code string, idempotencyKey uuid.UUID) *http.Response {
	type Req struct {
		SignInKey string `json:"signin_key"`
		Code      string `json:"code"`
	}
	reqBody, _ := json.Marshal(Req{
		SignInKey: signInKey,
		Code:      code,
	})

	req, err := http.NewRequest(http.MethodPost, common.ServiceUrl+"/v1.0/signin", bytes.NewReader(reqBody))
	require.NoError(t, err)
	req.Header.Add(common.HeaderIdemotencyKey, idempotencyKey.String())

	resp, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	return resp
}

func requestSendPhoneCode(t *testing.T, phone string) (signInKey string) {
	req := doSendCodeRequest(t, phone, uuid.New())
	body := common.GetBody(t, req.Body)

	type RespData struct {
		SignInKey string `json:"signin_key"`
	}
	var data RespData
	err := json.Unmarshal(body.Data, &data)
	require.NoError(t, err)

	return data.SignInKey
}

func getPhoneCode(t *testing.T, phone string) string {
	smsResp, err := http.Get("http://sms-service-stub:5023/" + phone)
	require.NoError(t, err)

	require.Equal(t, 200, smsResp.StatusCode)

	sms, err := io.ReadAll(smsResp.Body)
	smsResp.Body.Close()
	require.NoError(t, err)

	re := regexp.MustCompile(`\b\d{6}\b`)
	code := re.FindString(string(sms))

	require.NotEqual(t, "", code)

	return code
}
