//
//  VerifyAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

enum VerifyAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = VerifyPresenter()
        
        let verificationService = VerificationService()
        
        let worker = VerifyWorker(keychainManager: context.keychainManager,
                                  verificationService: verificationService)
        let interactor = VerifyInteractor(presentor: presenter, worker: worker)
        
        let view = VerifyViewController(interactor: interactor)
        
        presenter.view = view
        
        interactor.onRouteToSignupScreen = {
            coordinator.showSignupScreen()
        }
        
        return view
    }
}
