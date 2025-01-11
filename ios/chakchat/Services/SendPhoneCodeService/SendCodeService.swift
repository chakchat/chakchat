//
//  RegistrationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class SendPhoneService: SendPhoneServiceProtocols {
    
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest, completion: @escaping (Result<SendCodeModels.SuccessSendCodeData, APIError>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: SendCodeModels.SuccessSendCodeData.self,
            endpoint: SignupEndpoints.getCodeEndpoint.rawValue,
            completion: completion)
    }
    
}
