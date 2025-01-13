//
//  RegistrationPhoneValidator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
class PhoneValidator: SendCodeValidator {
    func validate(_ value: String) -> Bool {
        let phoneRegex = #"^\+7\(\d{3}\)\d{3}-\d{2}-\d{2}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: value)
    }
}
