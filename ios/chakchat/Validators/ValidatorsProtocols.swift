//
//  ValidatorsProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
protocol RegistrationValidator {
    func validate(_ value: String) -> Bool
}
