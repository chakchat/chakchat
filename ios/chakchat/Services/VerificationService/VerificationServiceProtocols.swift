//
//  VerificationServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
protocol VerificationServiceLogic{
    func send(_ request: Verify.SendVerifyCodeRequest,
              completion: @escaping (Result<Void, Error>) -> Void)
}
