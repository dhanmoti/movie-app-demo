//
//  SearchViewModelTests.swift
//  MovieDemoAppTests
//
//  Created by Dhan Moti on 27/10/24.
//

import XCTest
@testable import MovieDemoApp

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockNetworkService: MockMovieNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockMovieNetworkService()
        viewModel = SearchViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    // Test for successful movie search
    func testSearchMovies_successfulFetch_updatesMovies() async {
        // Arrange
        let expectedMovies = [
            MovieEntity(id: "tt1234567", title: "Movie 1"),
            MovieEntity(id: "tt7654321", title: "Movie 2")
        ]
        mockNetworkService.moviesToReturn = expectedMovies
        viewModel.searchText = "Movie"

        // Act
        await viewModel.searchMovies()

        // Assert
        XCTAssertEqual(viewModel.movies, expectedMovies)
        XCTAssertNil(viewModel.infoMessage)
    }

    // Test for failed movie search
    func testSearchMovies_fetchFails_setsInfoMessage() async {
        // Arrange
        mockNetworkService.shouldReturnError = true
        viewModel.searchText = "InvalidQuery"

        // Act
        await viewModel.searchMovies()

        // Assert
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertEqual(viewModel.infoMessage, "Something went wrong! Please try again.")
    }

    // Test for empty search text
    func testSearchMovies_withEmptySearchText_doesNotFetchMovies() async {
        // Arrange
        viewModel.searchText = ""

        // Act
        await viewModel.searchMovies()

        // Assert
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertNil(viewModel.infoMessage)  // Assuming no network call or error message for empty search text
    }
}
