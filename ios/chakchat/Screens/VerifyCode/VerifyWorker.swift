//
//  VerifyWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyWorker: VerifyWorkerLogic {
    
    private let verificationService: VerificationServiceLogic
    private let keychainManager: KeychainManagerBusinessLogic

    
    init(keychainManager: KeychainManagerBusinessLogic, verificationService: VerificationServiceLogic) {
        self.keychainManager = keychainManager
        self.verificationService = verificationService
    }
    
    func sendRequest(_ request: Verify.SendVerifyCodeRequest,
                     completion: @escaping (Result<Void, any Error>) -> Void) {
        print("Send request to service")
        verificationService.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Code confirmed")
                    let isDeleted = self.keychainManager.delete(key: KeychainManager.keyForSaveVerificationCode)
                    if isDeleted {
                        print("Code is successfully deleted")
                    } else {
                        print("Something went wrong, code isn't deleted from keychain storage!")
                    }
                    completion(.success(()))
                    // Move to signup screen
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                    // Start to cry
                }
            }
        }
    }
    
    func getVerifyCode() -> UUID? {
        guard let savedSignupKey = keychainManager.get(key: KeychainManager.keyForSaveVerificationCode) else {
            return nil
        }
        return savedSignupKey
    }
}
