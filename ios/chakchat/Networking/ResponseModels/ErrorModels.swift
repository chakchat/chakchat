//
//  ErrorModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

struct APIErrorResponse: Codable, Error {
    let errorType: String
    let errorMessage: String
    let errorDetails: [ErrorDetail]?
    
    enum CodingKeys: String, CodingKey {
        case errorType = "error_type"
        case errorMessage = "error_message"
        case errorDetails = "error_details"
    }
}

struct ErrorDetail: Codable {
    let field: String
    let message: String
}

