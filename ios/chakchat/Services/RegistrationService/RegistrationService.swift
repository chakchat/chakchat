//
//  RegistrationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
final class RegistrationService: RegistrationServiceLogic {

    let baseUrl = "http://localhost:80"
    
    func send(_ request: Registration.SendCodeRequest, 
              completion: @escaping (Result<UUID, Error>) -> Void) {
        print("Отправил серверу запрос")
        let phoneNumber = request.phone

        guard let url = URL(string: "\(baseUrl)/api/identity/v1.0/signin/send-phone-code") else {
            completion(.failure(RegistrationError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = Registration.SendCodeRequest(phone: phoneNumber)
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(RegistrationError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(RegistrationError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let response = try JSONDecoder().decode(SuccessResponse.self, from: data)
                    completion(.success(response.signinKey))
                } catch {
                    completion(.failure(error))
                }
            case 400:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(RegistrationError.dontKnow))
                } catch {
                    completion(.failure(error))
                }
            default:
                completion(.failure(RegistrationError.invalidResponse))
            }
        }.resume()
    }
}

struct SuccessResponse: Codable {
    let signinKey: UUID
    
    enum CodingKeys: String, CodingKey {
        case signinKey = "signin_key"
    }
}

struct ErrorResponse: Codable {
    let errorType: String
    let errorMessage: String
    let errorDetails: [String]
    
    enum CodingKeys: String, CodingKey {
        case errorType = "error_type"
        case errorMessage = "error_message"
        case errorDetails = "error_details"
    }
}
enum RegistrationError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case dontKnow
}
