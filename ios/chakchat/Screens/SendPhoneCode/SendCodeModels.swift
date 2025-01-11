//
//  RegistrationModel.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
enum SendCodeModels {
    
    struct SendCodeRequest: Codable {
        let phone: String
    }
        
    struct SuccessSendCodeSigninData: Codable {
        let signinKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signinKey = "signin_key"
        }
    }
    
    struct SuccessSendCodeSignupData: Codable {
        let signupKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
        }
    }
}
