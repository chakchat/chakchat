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
    func successTransition()
}

protocol SendCodePresentationLogic {
    func showError(_ error: Error)
}

protocol SendCodeWorkerLogic {
    func sendInRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<Void, Error>) -> Void)
    
    func sendUpRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<Void, Error>) -> Void)
}
