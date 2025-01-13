//
//  RegistrationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class SendCodeService: SendCodeServiceLogic {
    
    func sendCodeRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        Sender.send(
            requestBody: request,
            responseType: responseType,
            endpoint: endpoint,
            completion: completion
        )
    }
    
}
