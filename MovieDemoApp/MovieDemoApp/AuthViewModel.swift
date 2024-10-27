//
//  AuthViewModel.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage = ""
    @Published var isFailed = false
    
    private var storage: SecureStorage
    init(storage: SecureStorage = KeychainSecureStorage()) {
        self.storage = storage
    }
    
    func login(username: String, password: String) {
        // Input validation here
        if username.isEmpty {
            isFailed = true
            errorMessage = "Empty username!"
        }
        else if password.isEmpty {
            isFailed = true
            errorMessage = "Empty password!"
        }
        // Handle Firebase or hardcoded login
        else if username == "VVVBB" && password == "@bcd1234" {
            storage.saveCredentials(username: username, password: password)
            isAuthenticated = true
        }
        else {
            isFailed = true
            errorMessage = "Invalid Credentials! Please try agian."
        }
    }
}
