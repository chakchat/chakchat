//
//  RegistrationProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

protocol RegistrationBusinessLogic {
    func sendRegistrationRequest(_ request: Registration.SendCodeRequest)
}

protocol RegistrationPresentationLogic {
    
}

protocol RegistrationWorkerLogic {
    func sendRequest(_ request: Registration.SendCodeRequest)
}
