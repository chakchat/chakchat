//
//  ErrorHandler.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.01.2025.
//

import Foundation
import UIKit

final class ErrorHandler {
    static func handleError(_ error: Error) {
        if error is Keychain.KeychainError {
            guard let keychainError = error as? Keychain.KeychainError else {
                print("Error: Cant handle keychain error")
                return
            }
            handleKeychainError(keychainError)
        }
        
        if error is APIError {
            guard let apiError = error as? APIError else {
                print("Error: Cant handle api error ")
                return
            }
            handleApiError(apiError)
        }
        
        if error is APIErrorResponse {
            guard let apiErrorResponse = error as? APIErrorResponse else {
                print("Error: Cant handle api error response")
                return
            }
            handleApiResponseError(apiErrorResponse)
        }
    }
    
    static private func handleKeychainError(_ keychainError: Keychain.KeychainError) {
        switch keychainError {
        case Keychain.KeychainError.saveError:
            print("Error: Saving in keychain storage error")
            
        case Keychain.KeychainError.getError:
            print("Error: Getting from keychain storage error")
            
        case Keychain.KeychainError.deleteError:
            print("Error: Deleting from keychain storage error")
        }
    }
    
    static private func handleApiError(_ apiError: APIError) {
        switch apiError {
        case .invalidURL:
            print("Error: The URL is invalid.")
            
        case .invalidRequest:
            print("Error: The request is invalid.")
            
        case .networkError(let underlyingError):
            print("Error: Network error occurred. Details: \(underlyingError.localizedDescription)")
            
        case .invalidResponse:
            print("Error: Received an invalid response from the server.")
            
        case .noData:
            print("Error: No data received from the server.")
            
        case .decodingError(let decodingError):
            print("Error: Failed to decode the response. Details: \(decodingError.localizedDescription)")
            
        case .unknown:
            print("Error: An unknown error occurred.")
        }
    }

    static private func handleApiResponseError(_ apiResponseError: APIErrorResponse) {
        switch apiResponseError.errorType {
        case ApiErrorType.internalError.rawValue:
            print("Error: Internal server error.")
            
        case ApiErrorType.invalidJson.rawValue:
            print("Error: Invalid JSON received.")
            
        case ApiErrorType.validationFailed.rawValue:
            if let details = apiResponseError.errorDetails {
                let detailMessages = details.map { "\($0.field): \($0.message)" }.joined(separator: "\n")
                print("Error: Validation failed:\n\(detailMessages)")
            } else {
                print("Error: Validation failed.")
            }
            
        case ApiErrorType.userNotFound.rawValue:
            print("Error: User not found.")
            
        case ApiErrorType.idempotencyKeyMissing.rawValue:
            print("Error: Idempotency key is missing.")
            
        case ApiErrorType.sendCodeFreqExceeded.rawValue:
            print("Error: Too many requests. Please wait before retrying.")
            
        case ApiErrorType.signinKeyNotFound.rawValue:
            print("Error: Sign-in key not found.")
            
        case ApiErrorType.wrongCode.rawValue:
            print("Error: Incorrect code entered.")
            
        case ApiErrorType.refreshTokenExpired.rawValue:
            print("Error: Session expired. Please log in again.")
            
        case ApiErrorType.refreshTokenInvalidated.rawValue:
            print("Error: Session invalidated. Please log in again.")
            
        case ApiErrorType.invalidToken.rawValue:
            print("Error: Invalid token provided.")
            
        case ApiErrorType.invalidTokenType.rawValue:
            print("Error: Token type is invalid.")
            
        case ApiErrorType.unauthorized.rawValue:
            print("Error: Unauthorized access.")
            
        case ApiErrorType.accessTokenExpired.rawValue:
            print("Error: Access token expired.")
            
        case ApiErrorType.notFound.rawValue:
            print("Error: Requested resource not found.")
            
        case ApiErrorType.userAlreadyExists.rawValue:
            print("Error: User already exists.")
            
        case ApiErrorType.signupKeyNotFound.rawValue:
            print("Error: Sign-up key not found.")
            
        case ApiErrorType.usernameAlreadyExists.rawValue:
            print("Error: Username is already taken.")
            
        default:
            print("Error: An unknown error occurred.")
        }
    }
}
