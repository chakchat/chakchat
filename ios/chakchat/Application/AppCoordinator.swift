//
//  AppCoordinator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let signupContext: SignupContext

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.signupContext = SignupContext(keychainManager: KeychainManager())
    }

    func start() {
        let startVC = CreateStartScreen()
        navigationController.setViewControllers([startVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func CreateStartScreen() -> UIViewController {
        return StartAssembly.build(with: signupContext, coordinator: self)
    }
    
    func showRegistrationScreen() {
        let registrationVC = RegistrationAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(registrationVC, animated: true)
    }

    func showVerifyScreen() {
        let verifyVC = VerifyAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(verifyVC, animated: true)
    }
    
    func showSignupScreen() {
        let signupVC = SignupAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func finishSignupFlow() {
        let chatVC = CreateChatScreen()
        navigationController.setViewControllers([chatVC], animated: true)
    }

    private func CreateChatScreen() -> UIViewController {
        return UIViewController() // temporary, ChatScreen coming soon
    }
}
