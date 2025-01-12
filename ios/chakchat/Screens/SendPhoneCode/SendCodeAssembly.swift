//
//  RegistrationAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

enum SendCodeAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = SendCodePresenter()
        
        let sendCodeService = SendCodeService()
        
        let worker = SendCodeWorker(sendCodeService: sendCodeService, keychainManager: context.keychainManager)
        
        let interactor = SendCodeInteractor(presenter: presenter, worker: worker, state: context.state)
        let view = SendCodeViewController(interactor: interactor)
        presenter.view = view
        
        interactor.onRouteToVerifyScreen = { state in
            context.state = state
            print(state)
            coordinator.showVerifyScreen()
        }
        
        return view
    }
}
