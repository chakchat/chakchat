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
    func successTransition(_ state: AppState)
}

protocol SignupWorkerLogic {
    func sendRequest(_ request: Signup.SignupRequest,
                     completion: @escaping (Result<AppState, Error>) -> Void)
    
    func getSignupCode() -> UUID?
}

protocol SignupPresentationLogic {
    func showError(_ error: Error)
}
