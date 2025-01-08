//
//  VerifyModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
enum Verify {
    
    struct SendVerifyCodeRequest: Codable {
        let signupKey: UUID
        let code: String
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
            case code = "code"
        }
    }
    
    struct SuccessResponse: Codable {
        
    }
    
    struct ErrorResponse: Codable {
        let errorType: String
        let errorMessage: String
        let errorDetails: [ErrorDetail]?
        
        enum CodingKeys: String, CodingKey {
            case errorType = "error_type"
            case errorMessage = "error_message"
            case errorDetails = "error_details"
        }
    }
    
    struct ErrorDetail: Codable {
        let field: String
        let message: String
    }
}
