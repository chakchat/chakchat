//
//  RegistrationServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
protocol RegistrationServiceLogic {
    func send(_ request: Registration.SendCodeRequest,
              completion: @escaping (Result<UUID, Error>) -> Void)
}
