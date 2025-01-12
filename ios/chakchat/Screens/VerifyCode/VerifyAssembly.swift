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
        let interactor = VerifyInteractor(presentor: presenter, worker: worker, state: context.state)
        
        let view = VerifyViewController(interactor: interactor)
        
        presenter.view = view
        
        interactor.onRouteToSignupScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.showSignupScreen()
        }
        
        interactor.onRouteToChatScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.finishSignupFlow()
        }
        
        interactor.onRouteToSendCodeScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.popScreen()
        }
        
        return view
    }
}
