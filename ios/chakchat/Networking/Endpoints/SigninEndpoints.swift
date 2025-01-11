//
//  SigninEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 10.01.2025.
//

import Foundation
import UIKit
enum SigninEndpoints: String {
    case sendPhoneCodeEndpoint = "http://localhost:80/api/identity/v1.0/signin/send-phone-code"
    case signinEndpoint = "http://localhost:80/api/identity/v1.0/signin"
    case refreshEndpoint = "http://localhost:80/api/identity/v1.0/signin/refresh-token"
}
