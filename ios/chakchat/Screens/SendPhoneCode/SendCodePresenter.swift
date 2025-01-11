//
//  RegistrationPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

class SendCodePresenter: SendCodePresentationLogic {
    
    weak var view: SendCodeViewController?
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        view?.present(alert, animated: true, completion: nil)
    }
}
