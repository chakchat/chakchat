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
    
    func sendVerificationRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<AppState, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        print("Send request to service")
        verificationService.sendVerificationRequest(request,
                                                    endpoint,
                                                    responseType) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let successResponse):
                    guard let successResponse = successResponse as? SuccessModels.Tokens else {
                        completion(.success(AppState.signup))
                        return
                    }
                    self.saveToken(successResponse, completion: completion)
                    completion(.success(AppState._default))
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    func getVerifyCode(_ key: String) -> UUID? {
        guard let savedKey = keychainManager.getUUID(key: key) else {
            return nil
        }
        return savedKey
    }
    
    func saveToken(_ response: SuccessModels.Tokens, 
                   completion: @escaping (Result<AppState, Error>) -> Void) {
        var isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveAccessToken,
                                           value: response.accessToken)
        if !isSaved {
            completion(.failure(Keychain.KeychainError.saveError))
        }
        
        isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveRefreshToken,
                                            value: response.refreshToken)
        if isSaved {
            completion(.success(AppState._default))
        } else {
            completion(.failure(Keychain.KeychainError.saveError))
        }
    }
}
