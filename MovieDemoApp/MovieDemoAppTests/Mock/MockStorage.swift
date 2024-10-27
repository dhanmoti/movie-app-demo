//
//  MockStorage.swift
//  MovieDemoAppTests
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
@testable import MovieDemoApp

class MockSecureStorage: SecureStorage {
    var isSaveCredentialsCalled = false
    var savedUsername: String?
    var savedPassword: String?

    func saveCredentials(username: String, password: String) {
        isSaveCredentialsCalled = true
        savedUsername = username
        savedPassword = password
    }
}

