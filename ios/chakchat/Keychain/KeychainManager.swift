//
//  KeychainManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

final class KeychainManager: KeychainManagerBusinessLogic {
    
    static let keyForSaveSigninCode: String = "signinCode"
    static let keyForSaveSignupCode: String = "signupCode"
    static let keyForSaveAccessToken: String = "accessToken"
    static let keyForSaveRefreshToken: String = "refreshToken"
    
    // for verification code and other data with UUID type
    func save(key: String, value: UUID) -> Bool {
        return save(key: key, value: value.uuidString)
    }
    
    // for phone and other data with string type
    func save(key: String, value: String) -> Bool {
        
        guard let data = value.data(using: .utf8) else { return false }
        
        // Create query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Delete any existing item
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    // for verification code and other data with UUID type
    func getUUID(key: String) -> UUID? {
        guard let valueString = getPhone(key: key) else { return nil }
        return UUID(uuidString: valueString)
    }
    // for phone and other data with string type
    func getPhone(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data,
              let valueString = String(data: data, encoding: .utf8) else { return nil }
        return valueString
    }
    
    func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}

enum Keychain {
    enum KeychainError: Error {
        case saveError
        case getError
        case deleteError
    }
}

