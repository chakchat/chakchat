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
    
    func sendRequest(_ request: Verify.VerifyCodeRequest,
                     completion: @escaping (Result<Void, Error>) -> Void) {
        print("Send request to service")
        
        verificationService.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let apiError):
                    print("Something went wrong: \(apiError)")
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    func getVerifyCode() -> UUID? {
        guard let savedSignupKey = keychainManager.getUUID(key: KeychainManager.keyForSaveVerificationCode) else {
            return nil
        }
        return savedSignupKey
    }
}
