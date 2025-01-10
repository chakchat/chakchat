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
        
        view.onRouteToRegistrationScreen = {
            coordinator.showRegistrationScreen()
        }
        
        return view
    }
}
