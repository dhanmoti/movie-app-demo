//
//  SearchViewModel.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var infoMessage: String? = nil // Holds info or error messages
    @Published var movies: [MovieEntity] = []
    
    private var networkService: MovieNetworkService
    private var localDB: LocalDatabaseService
    init(networkService: MovieNetworkService = OMDBMovieNetworkService(),
         localDB: LocalDatabaseService = SQLightDBService()) {
        
        self.networkService = networkService
        self.localDB = localDB
    }
    
    func searchMovies() async {
        // Call OMDb API and store results in local database for offline support
        do {
            let newMovies = try await networkService.fetchMovies(query: searchText)
            localDB.saveMovies(newMovies)
            await MainActor.run { self.movies = newMovies }
        }
        catch
        {
            await MainActor.run {  infoMessage = "Something went wrong! Please try again." }
            await MainActor.run { self.movies = localDB.fetchMovies() }
        }
        
        
        
    }
}
