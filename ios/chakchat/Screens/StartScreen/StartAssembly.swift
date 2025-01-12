//
//  StartAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
enum StartAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController{
        let view = StartViewController()
        
        view.onRouteToSendCodeScreen = { state in
            context.state = state
            print(state)
            coordinator.showRegistrationScreen()
        }
        
        return view
    }
}
