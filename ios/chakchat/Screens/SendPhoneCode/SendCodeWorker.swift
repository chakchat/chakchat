//
//  RegistrationWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class SendCodeWorker: SendCodeWorkerLogic {
    
    private let sendCodeService: SendCodeServiceLogic
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(sendCodeService: SendCodeServiceLogic, keychainManager: KeychainManagerBusinessLogic) {
        self.sendCodeService = sendCodeService
        self.keychainManager = keychainManager
    }
    
    func sendInRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Send request to service")
        sendCodeService.sendCodeRequest(request,
                                        SigninEndpoints.sendPhoneCodeEndpoint.rawValue,
                                        SuccessModels.SendCodeSigninData.self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSigninCode,
                                                       value: successResponse.signinKey)
                    if isSaved {
                        completion(.success(AppState.signin))
                    } else {
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    if case .apiError(let apiErrorResponse) = apiError {
                        if apiErrorResponse.errorType == ApiErrorType.userNotFound.rawValue {
                            self.sendUpRequest(request, completion: completion)
                        }
                    } else {
                        completion(.failure(apiError))
                    }
                }
            }
        }
    }
    
    func sendUpRequest(_ request: SendCodeModels.SendCodeRequest,
                       completion: @escaping (Result<AppState, Error>) -> Void) {
        sendCodeService.sendCodeRequest(request,
                                        SignupEndpoints.sendPhoneCodeEndpoint.rawValue,
                                        SuccessModels.SendCodeSignupData.self) { [weak self]result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSignupCode,
                                                       value: successResponse.signupKey)
                    if isSaved {
                        completion(.success(AppState.signupVerifyCode))
                    } else {
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
}
