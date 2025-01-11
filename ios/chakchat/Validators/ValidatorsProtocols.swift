//
//  ValidatorsProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
protocol SendCodeValidator {
    func validate(_ value: String) -> Bool
}

protocol VerificationValidator {
    func validate(_ value: String) -> Bool
}

protocol SignupValidator {
    func validateName(_ value: String) -> Bool
    func validateUsername(_ value: String) -> Bool
}
