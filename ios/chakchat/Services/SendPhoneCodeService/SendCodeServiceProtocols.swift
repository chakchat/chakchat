//
//  RegistrationServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
protocol SendPhoneServiceProtocols {
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest,
                         completion: @escaping (Result<SendCodeModels.SuccessSendCodeData, APIError>) -> Void)
}
