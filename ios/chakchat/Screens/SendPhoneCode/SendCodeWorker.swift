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
                                        SuccessModels.SendCodeSigninData.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let successResponse):
                    print("Get signin code")
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSigninCode,
                                                       value: successResponse.signinKey)
                    if isSaved {
                        print("Saved signin key in keychain storage")
                        completion(.success(AppState.signin))
                    } else {
                        print("Something went wrong, signin isnt saved in keychain storage")
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    print("Something went wrong, dont get signin key")
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
                                        SuccessModels.SendCodeSignupData.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let successResponse):
                    print("Get signup code")
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSignupCode,
                                                       value: successResponse.signupKey)
                    if isSaved {
                        print("Saved signup key in keychain storage")
                        completion(.success(AppState.signupVerifyCode))
                    } else {
                        print("Something went wrong, signup isnt saved in keychain storage")
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    print("Something went wrong, dont get signup key")
                    completion(.failure(apiError))
                }
            }
        }
    }
}
