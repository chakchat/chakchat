//
//  SignupServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
protocol SignupServiceLogic {
    func sendSignupRequest(_ request: Signup.SignupRequest,
                           completion: @escaping (Result<SuccessModels.Tokens, Error>) -> Void)
}
