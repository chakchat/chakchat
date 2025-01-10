//
//  SignupPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
class SignupPresenter: SignupPresentationLogic {

    weak var view: SignupViewController?
    
    var onRouteToVerifyScreen: (() -> Void)?
    
    func presentSuccess() {
        onRouteToVerifyScreen?()
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        view?.present(alert, animated: true, completion: nil)
    }
}
