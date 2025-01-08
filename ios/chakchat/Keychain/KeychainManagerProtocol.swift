//
//  KeychainManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

protocol KeychainManagerBusinessLogic {
    func save(key: String, value: UUID) -> Bool
    func get(key: String) -> UUID?
    func delete(key: String) -> Bool
}
