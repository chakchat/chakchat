//
//  VerifyModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
enum Verify {
    
    struct VerifySigninRequest: Codable {
        let signinKey: UUID
        let code: String
        
        enum CodingKeys: String, CodingKey {
            case signinKey = "signin_key"
            case code = "code"
        }
    }
    
    struct VerifySignupRequest: Codable {
        let signupKey: UUID
        let code: String
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
            case code = "code"
        }
    }
}
