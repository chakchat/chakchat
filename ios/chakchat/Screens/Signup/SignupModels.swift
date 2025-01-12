//
//  SignupModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

enum Signup {
    
    struct SignupRequest: Codable {
        let signupKey: UUID
        let name: String
        let username: String
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
            case name = "name"
            case username = "username"
        }
    }
}
