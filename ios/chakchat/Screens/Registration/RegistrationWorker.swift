//
//  RegistrationWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class RegistrationWorker: RegistrationWorkerLogic {
    private let registrationService: RegistrationServiceLogic
    
    init(registrationService: RegistrationServiceLogic) {
        self.registrationService = registrationService
    }
    
    func sendRequest(_ request: Registration.SendCodeRequest) {
        print("Отправил запрос сервису")
        registrationService.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let signinKey):
                    print("Прислал код: \(signinKey)")
                    // Switch to input code screen
                case .failure(let error):
                    print("Ошибка: \(error)")
                    // Start to cry
                }
            }
        }
    }
}
