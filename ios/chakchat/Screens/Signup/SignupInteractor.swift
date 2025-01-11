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
    
    var onRouteToChatScreen: (() -> Void)?
    
    init(presenter: SignupPresentationLogic, worker: SignupWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func sendSignupRequest(_ name: String, _ username: String) {
        print("Send request to worker")
        let signupKey: UUID! = worker.getSignupCode()
        if signupKey != nil {
            worker.sendRequest(Signup.SignupRequest(signupKey: signupKey, name: name, username: username)) { result in
                switch result {
                case .success:
                    print("Succes")
                    self.successTransition()
                case .failure(let error):
                    print("Error: \(error)")
                    self.presenter.showError(error)
                }
            }
        } else {
            print("Can't find signup key in keychain storage!")
        }
    }
    
    func successTransition() {
        onRouteToChatScreen?()
    }
}
