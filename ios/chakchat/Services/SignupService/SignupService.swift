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
                           completion: @escaping (Result<SuccessModels.Tokens, Error>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: SuccessModels.Tokens.self,
            endpoint: SignupEndpoints.signupEndpoint.rawValue,
            completion: completion)
    }
    
}
