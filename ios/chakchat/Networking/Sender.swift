//
//  Sender.swift
//  chakchat
//
//  Created by Кирилл Исаев on 10.01.2025.
//

import Foundation
import UIKit
final class Sender {
    static func send<T: Codable, U: Codable>(
        requestBody: T,
        responseType: U.Type,
        endpoint: String,
        completion: @escaping (Result<U, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(UUID().uuidString, forHTTPHeaderField: "Idempotency-Key")
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            completion(.failure(APIError.invalidRequest))
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(APIError.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let responseData = try JSONDecoder().decode(SuccessResponse<U>.self, from: data)
                    completion(.success(responseData.data))
                } catch {
                    completion(.failure(APIError.decodingError(error)))
                }
            default:
                do {
                    let errorResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    completion(.failure(APIError.apiError(errorResponse)))
                } catch {
                    completion(.failure(APIError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}

struct SuccessResponse<T: Codable>: Codable {
    let data: T
}
