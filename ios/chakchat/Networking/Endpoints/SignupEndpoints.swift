//
//  SignupEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

enum SignupEndpoints: String {
    case sendPhoneCodeEndpoint = "http://localhost:80/api/identity/v1.0/signup/send-phone-code"
    case verifyCodeEndpoint = "http://localhost:80/api/identity/v1.0/signup/verify-code"
    case signupEndpoint = "http://localhost:80/api/identity/v1.0/signup"
}
