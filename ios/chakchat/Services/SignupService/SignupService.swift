//
//  SignupService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupService: SignupServiceLogic {
    
    func sendSignupRequest(_ request: Signup.SignupRequest, completion: @escaping (Result<Signup.SuccessSignupResponse, APIError>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: Signup.SuccessSignupResponse.self,
            endpoint: SignupEndpoints.signupEndpoint.rawValue,
            completion: completion)
    }
    
}
