//
//  SecureStorage.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
import Security

protocol SecureStorage {
    func saveCredentials(username: String, password: String)
}

class KeychainSecureStorage: SecureStorage {
    func saveCredentials(username: String, password: String) {
        let account = username
        let passwordData = password.data(using: .utf8)!
        
        // Prepare keychain query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: passwordData
        ]
        
        // Check if credentials already exist
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            // Update existing item
            let attributesToUpdate: [String: Any] = [kSecValueData as String: passwordData]
            SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        } else {
            // Add new item
            SecItemAdd(query as CFDictionary, nil)
        }
    }
}

