//
//  MockMovieNetworkService.swift
//  MovieDemoAppTests
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
@testable import MovieDemoApp

class MockMovieNetworkService: MovieNetworkService {
    var shouldReturnError = false
    var moviesToReturn: [MovieEntity] = []
    
    func fetchMovies(query: String) async throws -> [MovieEntity] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return moviesToReturn
    }
}
