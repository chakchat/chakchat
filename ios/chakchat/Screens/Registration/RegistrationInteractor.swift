//
//  RegistrationInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
class RegistrationInteractor: RegistrationBusinessLogic {
    
    private var presenter: RegistrationPresentationLogic
    private var worker: RegistrationWorkerLogic
    
    init(presenter: RegistrationPresentationLogic, worker: RegistrationWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func sendRegistrationRequest(_ request: Registration.SendCodeRequest) {
        print("Send request to worker")
        /*
        worker.sendRequest(request) { result in
            switch result {
            case .success:
                self.presenter.presentSuccess()
                // Route to verify code screen
            case .failure(let error):
                self.presenter.showError(error)
                print("Error: \(error)")
            }
        }
        */
        presenter.presentSuccess()
    }
}
