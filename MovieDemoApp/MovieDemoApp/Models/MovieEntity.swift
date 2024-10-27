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
    var year: String?
    var genre: String?
    var director: String?
    var plot: String?
    var poster: String?
}
extension MovieEntity: Hashable {}
