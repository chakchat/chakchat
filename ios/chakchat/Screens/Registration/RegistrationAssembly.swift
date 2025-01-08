//
//  RegistrationAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

enum RegistrationAssembly {
    static func build() -> UIViewController {
        let presenter = RegistrationPresenter()
        
        let registrationService = RegistrationService()
        let keychainManager = KeychainManager()
        
        let worker = RegistrationWorker(registrationService: registrationService,
                                        keychainManager: keychainManager)
        
        let interactor = RegistrationInteractor(presenter: presenter, worker: worker)
        let view = RegistrationViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
