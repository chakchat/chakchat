//
//  SignupWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
class SignupWorker: SignupWorkerLogic {

    private let keychainManager: KeychainManagerBusinessLogic
    let signupService: SignupServiceLogic
    
    init(keychainManager: KeychainManagerBusinessLogic, signupService: SignupServiceLogic) {
        self.keychainManager = keychainManager
        self.signupService = signupService
    }
    
    func sendRequest(_ request: Signup.SignupRequest, completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Send request to service")
        
        signupService.sendSignupRequest(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let successResponse):
                    self.saveToken(successResponse, completion: completion)
                    completion(.success(AppState._default))
                case .failure(let apiError):
                    print("Something went wrong: \(apiError)")
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    func getSignupCode() -> UUID? {
        guard let savedSignupKey = keychainManager.getUUID(key: KeychainManager.keyForSaveSignupCode) else {
            return nil
        }
        return savedSignupKey
    }
    
    func saveToken(_ successResponse: SuccessModels.Tokens,
                   completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Access token: \(successResponse.accessToken)\nRefresh token: \(successResponse.refreshToken)")
        var isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveAccessToken,
                                           value: successResponse.accessToken)
        if isSaved {
            print("Access token is saved in keychain storage")
        } else {
            print("Something went wrong, access token isnt saved in keychain storage")
            completion(.failure(Keychain.KeychainError.saveError))
        }
        
        isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveRefreshToken,
                                            value: successResponse.refreshToken)
        
        if isSaved {
            print("Refresh token is saved in keychain storage")
        } else {
            print("Something went wrong, refresh token isnt saved in keychain storage")
            completion(.failure(Keychain.KeychainError.saveError))
        }
    }
}
