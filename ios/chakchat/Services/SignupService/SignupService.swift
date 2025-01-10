//
//  SignupService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupService: SignupServiceLogic {
    
    func sendSignupRequest(_ request: Signup.SignupRequest,
                           completion: @escaping (Result<Signup.SuccessSignupData, APIError>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: Signup.SuccessSignupData.self,
            endpoint: SignupEndpoints.signupEndpoint.rawValue,
            completion: completion)
    }
    
}
