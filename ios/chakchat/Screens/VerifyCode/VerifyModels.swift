//
//  VerifyModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
enum Verify {
    
    struct VerifyCodeRequest: Codable {
        let signupKey: UUID
        let code: String
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
            case code = "code"
        }
    }
    
    struct SuccessVerifyResponse: Codable {
        let data: SuccessVerifyData
    }
    
    struct SuccessVerifyData: Codable {}
}
