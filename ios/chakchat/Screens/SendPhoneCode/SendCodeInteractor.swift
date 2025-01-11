//
//  RegistrationInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
class SendCodeInteractor: SendCodeBusinessLogic {

    private var presenter: SendCodePresentationLogic
    private var worker: SendCodeWorkerLogic
    
    var onRouteToVerifyScreen: (() -> Void)?
    
    init(presenter: SendCodePresentationLogic, worker: SendCodeWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest) {
        print("Send request to worker")
        worker.sendInRequest(request) { result in
            switch result {
            case .success:
                self.successTransition()
                // Route to verify code screen
            case .failure(let error):
                self.presenter.showError(error)
                print("Error: \(error)")
            }
        }
    }
    
    func successTransition() {
        onRouteToVerifyScreen?()
    }
}
