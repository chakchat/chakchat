//
//  VerifyInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyInteractor: VerifyBusinessLogic {
    
    private var presentor: VerifyPresentationLogic
    private var worker: VerifyWorkerLogic
    
    var onRouteToSignupScreen: (() -> Void)?
    
    init(presentor: VerifyPresentationLogic, worker: VerifyWorkerLogic) {
        self.presentor = presentor
        self.worker = worker
    }
    
    func sendVerificationRequest(_ code: String) {
        print("Send request to worker")
        let signupKey: UUID! = worker.getVerifyCode()
        if signupKey != nil {
            worker.sendRequest(Verify.VerifyCodeRequest(signupKey: signupKey, code: code)) { result in
                switch result {
                case .success:
                    print("Succes")
                    self.successTransition()
                case .failure(let error):
                    print("Error: \(error)")
                    self.presentor.showError(error)
                }
            }
        } else {
            print("Cant find signupKey in keychain")
        }
    }
    
    func successTransition() {
        onRouteToSignupScreen?()
    }
}
