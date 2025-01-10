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
    
    init(keychainManager: KeychainManagerBusinessLogic) {
        self.keychainManager = keychainManager
    }
}
