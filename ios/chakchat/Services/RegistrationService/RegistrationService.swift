//
//  RegistrationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class RegistrationService: RegistrationServiceLogic {
    
    func sendRegistrationRequest(_ request: Registration.SendCodeRequest, completion: @escaping (Result<Registration.SuccessRegistrationResponse, APIError>) -> Void) {
        Sender.send(
            requestBody: request,
            responseType: Registration.SuccessRegistrationResponse.self,
            endpoint: SignupEndpoints.getCodeEndpoint.rawValue,
            completion: completion)
    }
    
}
