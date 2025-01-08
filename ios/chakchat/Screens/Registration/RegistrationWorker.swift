//
//  RegistrationWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class RegistrationWorker: RegistrationWorkerLogic {
    
    enum Constants {
        static let keyForSaveVerificationCode: String = "verificationCode"
    }
    
    private let registrationService: RegistrationServiceLogic
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(registrationService: RegistrationServiceLogic, keychainManager: KeychainManager) {
        self.registrationService = registrationService
        self.keychainManager = keychainManager
    }
    
    func sendRequest(_ request: Registration.SendCodeRequest) {
        print("Отправил запрос сервису")
        registrationService.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let signinKey):
                    print("Прислал код: \(signinKey)")
                    let isSaved = self.keychainManager.save(key: Constants.keyForSaveVerificationCode,
                                                       value: signinKey)
                    if isSaved {
                        print("Verification code is saved")
                    } else {
                        print("Verification code isn't saved")
                    }
                case .failure(let error):
                    print("Ошибка: \(error)")
                    // Start to cry
                }
            }
        }
    }
}
