//
//  VerifyProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

protocol VerifyBusinessLogic {
    func sendVerificationRequest(_ code: String)
}

protocol VerifyPresentationLogic {
    func presentSuccess()
    func showError(_ error: Error)
}

protocol VerifyWorkerLogic {
    func sendRequest(_ request: Verify.VerifyCodeRequest,
                     completion: @escaping (Result<Void, Error>) -> Void)
    func getVerifyCode() -> UUID?
}
