//
//  VerificationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class VerificationService: VerificationServiceLogic {
    
    let baseUrl = "http://localhost:80"
    
    func send(_ request: Verify.SendVerifyCodeRequest, completion: @escaping (Result<Void, any Error>) -> Void) {
        print("Send request to server")
        let signupKey = request.signupKey
        let code = request.code
        
        guard let url = URL(string: SignupEndpoints.verifyCode.rawValue) else {
            completion(.failure(VerificationError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = Verify.SendVerifyCodeRequest(signupKey: signupKey, code: code)
        
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
                completion(.failure(VerificationError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(VerificationError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let response = try JSONDecoder().decode(Verify.SuccessResponse.self, from: data)
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            case 400:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorModels.ErrorResponse.self, from: data)
                    completion(.failure(VerificationError.dontKnow))
                } catch {
                    completion(.failure(error))
                }
            default:
                completion(.failure(VerificationError.invalidResponse))
            }
        }.resume()
    }
}

enum VerificationError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case dontKnow
}
