//
//  RegistrationProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

protocol SendCodeBusinessLogic {
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest)
    func successTransition(_ state: AppState)
}

protocol SendCodePresentationLogic {
    func showError(_ error: Error)
}

protocol SendCodeWorkerLogic {
    func sendInRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<AppState, Error>) -> Void)
    
    func sendUpRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<AppState, Error>) -> Void)
}
