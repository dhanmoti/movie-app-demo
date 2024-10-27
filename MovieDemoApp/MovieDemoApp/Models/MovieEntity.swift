//
//  MovieEntity.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation

struct MovieEntity {
    var id: String
    var title: String?
    var summary: String?
    var posterUrl: URL?
    var imdbRating: String?
    var imdbTotalRating: String = "10"
    var imdbVotes: String?
    var genre: String? //comma separated values
    var otherRatings: [Rating]?
    
    struct Rating: Hashable, Codable {
        var source: String
        var value: String? // value/total
    }
}
extension MovieEntity: Hashable {
    static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(summary)
        hasher.combine(posterUrl)
        hasher.combine(imdbRating)
        hasher.combine(imdbTotalRating)
        hasher.combine(imdbVotes)
        hasher.combine(genre)
        hasher.combine(otherRatings)
    }
}

