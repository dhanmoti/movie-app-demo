//
//  MoviesResponse.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
struct MovieListResponse: Decodable {
   let movies: [Movie]
   
   enum CodingKeys: String, CodingKey {
       case movies = "Search"
   }
}

struct Movie: Identifiable, Decodable {
   let id: String
   let title: String
   let year: String
   let poster: String?
   
   enum CodingKeys: String, CodingKey {
       case id = "imdbID"
       case title = "Title"
       case year = "Year"
       case poster = "Poster"
   }
}

//struct MovieDetail: Decodable {
//   let id: String
//   let title: String
//   let year: String
//   let genre: String
//   let director: String
//   let plot: String
//   let poster: String?
//   
//   enum CodingKeys: String, CodingKey {
//       case id = "imdbID"
//       case title = "Title"
//       case year = "Year"
//       case genre = "Genre"
//       case director = "Director"
//       case plot = "Plot"
//       case poster = "Poster"
//   }
//}
