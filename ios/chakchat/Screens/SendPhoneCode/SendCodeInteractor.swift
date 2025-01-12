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
    private var state: AppState
    
    var onRouteToVerifyScreen: ((AppState) -> Void)?
    
    init(presenter: SendCodePresentationLogic, worker: SendCodeWorkerLogic, state: AppState) {
        self.presenter = presenter
        self.worker = worker
        self.state = state
    }
    
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest) {
        print("Send request to worker")
        worker.sendInRequest(request) { result in
            switch result {
            case .success(let state):
                self.successTransition(state)
            case .failure(let apiError):
                self.presenter.showError(apiError)
            }
        }
    }
    
    func successTransition(_ state: AppState) {
        
        onRouteToVerifyScreen?(state)
    }
}
