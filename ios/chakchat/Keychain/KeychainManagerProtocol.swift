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
    func save(key: String, value: String) -> Bool
    func getUUID(key: String) -> UUID?
    func getPhone(key: String) -> String?
    func delete(key: String) -> Bool
}
