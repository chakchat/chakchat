//
//  SignupEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

enum SignupEndpoints: String {
    case requestCode = "http://localhost:80/api/identity/v1.0/signup/request-code"
    case verifyCode = "http://localhost:80/api/identity/v1.0/signup/verify-code"
}
