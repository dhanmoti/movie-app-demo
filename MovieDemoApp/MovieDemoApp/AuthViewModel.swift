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
    
    func login(username: String, password: String) {
        // Input validation here
        // Handle Firebase or hardcoded login
        if username == "VVVBB" && password == "@bcd1234" {
            isAuthenticated = true
        }
        else {
            isFailed = true
            errorMessage = "Invalid Credentials! Please try agian."
        }
    }
}
