//
//  SignupContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupContext {
    
    let keychainManager: KeychainManagerBusinessLogic
    var state: AppState
    
    init(keychainManager: KeychainManagerBusinessLogic, state: AppState) {
        self.keychainManager = keychainManager
        self.state = state
    }
}
