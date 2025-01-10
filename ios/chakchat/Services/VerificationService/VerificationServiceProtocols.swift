//
//  VerificationServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
protocol VerificationServiceLogic {
    func sendVerificationRequest(_ request: Verify.VerifyCodeRequest,
              completion: @escaping (Result<Verify.SuccessVerifyResponse, APIError>) -> Void)
}
