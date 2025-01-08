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
        print("Отправил запрос воркеру")
        worker.sendRequest(request)
    }
    
}
