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
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(registrationService: RegistrationServiceLogic, keychainManager: KeychainManager) {
        self.registrationService = registrationService
        self.keychainManager = keychainManager
    }
    
    func sendRequest(_ request: Registration.SendCodeRequest,
                     completion: @escaping (Result<Void, Error>) -> Void) {
        print("Send request to service")
        registrationService.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let signinKey):
                    print("Save current phone number")
                    var isSaved = self.keychainManager.save(key: KeychainManager.keyForSavePhoneNumber,
                                                            value: request.phone)
                    if isSaved {
                        print("Phone number is saved")
                    } else {
                        print("Something went wrong, phone numbers isnt saved in keychain storage!")
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                    
                    print("Get code: \(signinKey)")
                    isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveVerificationCode,
                                                       value: signinKey)
                    if isSaved {
                        print("Verification code is saved")
                        completion(.success(())) // Move to verify code screen
                    } else {
                        print("Verification code isn't saved")
                        completion(.failure((Keychain.KeychainError.saveError)))
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                    // Start to cry
                }
            }
        }
    }
}
