//
//  RemoteRepo.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation

protocol MovieNetworkService {
    func fetchMovies(query: String) async throws -> [MovieEntity]
    func fetchMovieDetails(movieID: String) async throws -> MovieEntity
    
}

class OMDBMovieNetworkService: MovieNetworkService {
   private let apiKey = "6fc87060"
   
   /// Fetches a list of movies based on a search query
   func fetchMovies(query: String) async throws -> [MovieEntity] {
       guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(query)&type=movie") else {
           throw URLError(.badURL)
       }
       print(url)
       
       let (data, response) = try await URLSession.shared.data(from: url)
       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           throw URLError(.badServerResponse)
       }
       
       let decodedResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
       return decodedResponse.movies.map { MovieEntity(id: $0.id, title: $0.title, posterUrl: URL(string: $0.poster ?? ""))}
   }
   
   // Fetches details for a specific movie by its ID
   func fetchMovieDetails(movieID: String) async throws -> MovieEntity {
       guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(movieID)") else {
           throw URLError(.badURL)
       }

       let (data, response) = try await URLSession.shared.data(from: url)
       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
           throw URLError(.badServerResponse)
       }

       let decodedResponse = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
       
       let ratings = (decodedResponse.ratings ?? [] ).map { MovieEntity.Rating(source: $0.source ?? "", value: $0.value)}
       
       let movieEntity = MovieEntity(id: decodedResponse.imdbID,
                                     title: decodedResponse.title,
                                     summary: decodedResponse.plot,
                                     posterUrl: URL(string: decodedResponse.poster ?? ""),
                                     imdbRating: decodedResponse.imdbRating,
                                     imdbVotes: decodedResponse.imdbVotes,
                                     genre: decodedResponse.genre,
                                     otherRatings: ratings)
       return movieEntity
   }
}
