package handlers

import (
	"fmt"

	"github.com/chakchat/chakchat/backend/file-storage/internal/restapi"
	"github.com/chakchat/chakchat/backend/file-storage/internal/services"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type MultipartUploadConfig struct {
	MinFileSize int64
	MaxPartSize int64
}

type UploadInitService interface {
	Init(*services.UploadInitRequest) (uploadId uuid.UUID, err error)
}

func UploadInit(conf *MultipartUploadConfig, service UploadInitService) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req uploadInitRequest
		if err := c.ShouldBindBodyWithJSON(&req); err != nil {
			restapi.SendUnprocessableJSON(c)
			return
		}

		if errors := validateUploadInit(conf, &req); len(errors) != 0 {
			restapi.SendValidationError(c, errors)
			return
		}

		uploadId, err := service.Init(&services.UploadInitRequest{
			FileName: req.FileName,
			FileSize: req.FileSize,
			MimeType: req.MimeType,
		})
		if err != nil {
			// TODO: for now I don't know what may occur here
			// But please handle errors properly.
			restapi.SendInternalError(c)
			return
		}

		restapi.SendSuccess(c, uploadInitResponse{
			UploadId: uploadId,
		})
	}
}

type uploadInitRequest struct {
	FileName string `json:"file_name" binding:"required"`
	FileSize int64  `json:"file_size" binding:"required"`
	MimeType string `json:"mime_type" binding:"required"`
}

type uploadInitResponse struct {
	UploadId uuid.UUID
}

func validateUploadInit(conf *MultipartUploadConfig, req *uploadInitRequest) []restapi.ErrorDetail {
	var errors []restapi.ErrorDetail
	if req.FileSize < conf.MinFileSize {
		errors = append(errors, restapi.ErrorDetail{
			Field:   "file_size",
			Message: fmt.Sprintf("File size must be not less than %d bytes", conf.MinFileSize),
		})
	}
	return errors
}
