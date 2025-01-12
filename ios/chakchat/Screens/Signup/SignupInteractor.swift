//
//  SignupInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
class SignupInteractor: SignupBusinessLogic {

    private let presenter: SignupPresentationLogic
    private let worker: SignupWorkerLogic
    private let state: AppState
    
    var onRouteToChatScreen: ((AppState) -> Void)?
    
    init(presenter: SignupPresentationLogic, worker: SignupWorkerLogic, state: AppState) {
        self.presenter = presenter
        self.worker = worker
        self.state = state
    }
    
    func sendSignupRequest(_ name: String, _ username: String) {
        print("Send request to worker")
        let signupKey: UUID! = worker.getSignupCode()
        if signupKey != nil {
            worker.sendRequest(Signup.SignupRequest(signupKey: signupKey, name: name, username: username)) { result in
                switch result {
                case .success(let state):
                    self.successTransition(state)
                case .failure(let error):
                    ErrorHandler.handleError(error)
                    self.presenter.showError(error)
                }
            }
        } else {
            print("Can't find signup key in keychain storage!")
        }
    }
    
    func successTransition(_ state: AppState) {
        onRouteToChatScreen?(AppState._default)
    }
}
