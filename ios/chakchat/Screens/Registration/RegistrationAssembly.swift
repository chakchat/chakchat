//
//  RegistrationAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

enum RegistrationAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = RegistrationPresenter()
        
        let registrationService = RegistrationService()
        
        let worker = RegistrationWorker(registrationService: registrationService,
                                        keychainManager: context.keychainManager)
        
        let interactor = RegistrationInteractor(presenter: presenter, worker: worker)
        let view = RegistrationViewController(interactor: interactor)
        presenter.view = view
        
        presenter.onRouteToVerifyScreen = {
            coordinator.showVerifyScreen()
        }
        
        return view
    }
}
