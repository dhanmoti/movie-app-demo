//
//  MovieDetailViewModel.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
class MovieDetailViewModel: ObservableObject {
    @Published var infoMessage: String? = nil // Holds info or error messages
    @Published var movie: MovieEntity
    @Published var starRating: Double = 0.0
    
    private var networkService: MovieNetworkService
    init(networkService: MovieNetworkService = OMDBMovieNetworkService(), movie: MovieEntity) {
        self.networkService = networkService
        self.movie = movie
    }
    
    func loadMovie() async {
        // Call OMDb API and store results in local database for offline support
        do {
            let newMovie = try await networkService.fetchMovieDetails(movieID: movie.id)
            
            await MainActor.run {
                movie = newMovie
                starRating = (Double(movie.imdbRating ?? "0") ?? 0.0) / 2.0
            }
            
        }
        catch
        {
            await MainActor.run {  infoMessage = "Something went wrong! Please try again." }
        }
        
        
    }
}
