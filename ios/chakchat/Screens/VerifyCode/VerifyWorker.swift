//
//  VerifyWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyWorker: VerifyWorkerLogic {
    
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(keychainManager: KeychainManagerBusinessLogic) {
        self.keychainManager = keychainManager
    }
    
    func sendRequest(_ request: Verify.SendVerifyCodeRequest,
                     completion: @escaping (Result<Void, any Error>) -> Void) {
        print("Send request to service")
    }
    
    func getVerifyCode() -> UUID? {
        guard let savedSignupKey = keychainManager.get(key: KeychainManager.keyForSaveVerificationCode) else {
            return nil
        }
        return savedSignupKey
    }
}
