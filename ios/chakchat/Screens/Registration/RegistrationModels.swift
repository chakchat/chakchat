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
    
    struct SendCodeResponse: Codable {
        let signinKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signinKey = "signin_key"
        }
    }
}
