//
//  SignupProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
protocol SignupBusinessLogic {
    func sendSignupRequest(_ name: String, _ username: String)
}

protocol SignupWorkerLogic {
    func sendRequest(_ request: Signup.SignupRequest,
                     completion: @escaping (Result<Void, Error>) -> Void)
    
    func getSignupCode() -> UUID?
}

protocol SignupPresentationLogic {
    func presentSuccess()
    func showError(_ error: Error)
}
