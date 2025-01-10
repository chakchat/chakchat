//
//  RegistrationServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
protocol RegistrationServiceLogic {
    func sendRegistrationRequest(_ request: Registration.SendCodeRequest,
              completion: @escaping (Result<Registration.SuccessRegistrationResponse, APIError>) -> Void)
}
