//
//  VerifyAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

enum VerifyAssembly {
    static func build() -> UIViewController {
        let presentor = VerifyPresenter()
        
        let verificationService = VerificationService()
        let keychainManager = KeychainManager()
        
        let worker = VerifyWorker(keychainManager: keychainManager, 
                                  verificationService: verificationService)
        
        let interactor = VerifyInteractor(presentor: presentor, worker: worker)
        let view = VerifyViewController(interactor: interactor)
        
        presentor.view = view
        
        return view
    }
}
