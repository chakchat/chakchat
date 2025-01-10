//
//  RegistrationModel.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
enum Registration {
    
    struct SendCodeRequest: Codable {
        let phone: String
    }
    
    struct SuccessRegistrationResponse: Codable {
        let data: SuccessVerifyData
    }
    
    struct SuccessVerifyData: Codable {
        let signupKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
        }
    }
}
