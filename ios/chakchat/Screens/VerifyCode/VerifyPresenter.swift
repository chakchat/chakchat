//
//  VerifyPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyPresenter: VerifyPresentationLogic {

    weak var view: VerifyViewController?
    
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        view?.present(alert, animated: true, completion: nil)
    }
}
