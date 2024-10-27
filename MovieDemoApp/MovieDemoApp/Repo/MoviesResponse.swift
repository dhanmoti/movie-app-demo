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
