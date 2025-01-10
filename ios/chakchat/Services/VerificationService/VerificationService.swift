//
//  VerificationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class VerificationService: VerificationServiceLogic {
    
    func sendVerificationRequest(_ request: Verify.VerifyCodeRequest, completion: @escaping (Result<Verify.SuccessVerifyData, APIError>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: Verify.SuccessVerifyData.self,
            endpoint: SignupEndpoints.verifyCodeEndpoint.rawValue,
            completion: completion)
    }
    
}
