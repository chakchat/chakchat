//
//  ErrorTypes.swift
//  chakchat
//
//  Created by Кирилл Исаев on 10.01.2025.
//

import Foundation
import UIKit
enum ApiErrorType: String, Codable {
    case internalError = "internal"
    case invalidJson = "invalid_json"
    case validationFailed = "validation_failed"
    case userNotFound = "user_not_found"
    case idempotencyKeyMissing = "idempotency_key_missing"
    case sendCodeFreqExceeded = "send_code_freq_exceeded"
    case signinKeyNotFound = "signin_key_not_found"
    case wrongCode = "wrong_code"
    case refreshTokenExpired = "refresh_token_expired"
    case refreshTokenInvalidated = "refresh_token_invalidated"
    case invalidToken = "invalid_token"
    case invalidTokenType = "invalid_token_type"
    case unauthorized = "unauthorized"
    case accessTokenExpired = "access_token_expired"
    case notFound = "not_found"
    case userAlreadyExists = "user_already_exists"
    case signupKeyNotFound = "signup_key_not_found"
    case usernameAlreadyExists = "username_already_exists"
}

enum APIError: Error {
    case invalidURL
    case invalidRequest
    case networkError(Error)
    case invalidResponse
    case noData
    case decodingError(Error)
    case apiError(APIErrorResponse)
    case unknown
}

