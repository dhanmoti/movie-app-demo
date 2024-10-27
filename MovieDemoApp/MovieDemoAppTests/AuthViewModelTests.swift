//
//  AuthViewModelTests.swift
//  MovieDemoAppTests
//
//  Created by Dhan Moti on 27/10/24.
//

import XCTest
@testable import MovieDemoApp

final class AuthViewModelTests: XCTestCase {

    var viewModel: AuthViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = AuthViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        super.tearDown()
    }

    // Test for empty username
    func testLogin_withEmptyUsername_showsErrorMessage() {
        // Act
        viewModel.login(username: "", password: "password")
        
        // Assert
        XCTAssertTrue(viewModel.isFailed)
        XCTAssertEqual(viewModel.errorMessage, "Empty username!")
        XCTAssertFalse(viewModel.isAuthenticated)
    }
    
    // Test for empty password
    func testLogin_withEmptyPassword_showsErrorMessage() {
        // Act
        viewModel.login(username: "username", password: "")
        
        // Assert
        XCTAssertTrue(viewModel.isFailed)
        XCTAssertEqual(viewModel.errorMessage, "Empty password!")
        XCTAssertFalse(viewModel.isAuthenticated)
    }

    // Test for successful login
    func testLogin_withValidCredentials_setsIsAuthenticated() {
        // Act
        viewModel.login(username: "VVVBB", password: "@bcd1234")
        
        // Assert
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertFalse(viewModel.isFailed)
        XCTAssertEqual(viewModel.errorMessage, "")
    }

    // Test for invalid credentials
    func testLogin_withInvalidCredentials_showsErrorMessage() {
        // Act
        viewModel.login(username: "invalidUser", password: "wrongPassword")
        
        // Assert
        XCTAssertTrue(viewModel.isFailed)
        XCTAssertEqual(viewModel.errorMessage, "Invalid Credentials! Please try agian.")
        XCTAssertFalse(viewModel.isAuthenticated)
    }

}
