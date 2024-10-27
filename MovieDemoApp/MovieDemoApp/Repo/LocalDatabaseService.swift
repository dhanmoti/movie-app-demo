//
//  LocalDatabaseService.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
import SQLite3

protocol LocalDatabaseService {
    func saveMovies(_ movies: [MovieEntity])
    func fetchMovies() -> [MovieEntity]
}

class SQLightDBService: LocalDatabaseService {
    private var db: OpaquePointer?
    
    init() {
        openDatabase()
        createMoviesTable()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    // Open the SQLite database (or create it if it doesn't exist)
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("MoviesDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Failed to open database.")
        }
    }
    
    // Create the movies table if it doesn't exist
    private func createMoviesTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Movies (
            id TEXT PRIMARY KEY,
            title TEXT,
            summary TEXT,
            posterUrl TEXT,
            imdbRating TEXT,
            imdbTotalRating TEXT DEFAULT '10',
            imdbVotes TEXT,
            genre TEXT,
            otherRatings TEXT, -- JSON encoded
            dateAdded DATETIME DEFAULT CURRENT_TIMESTAMP
        );
        """
        
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Failed to create table: \(String(cString: sqlite3_errmsg(db)!))")
        }
    }
    
    // Helper function to encode otherRatings to JSON
    private func encodeRatings(_ ratings: [MovieEntity.Rating]?) -> String? {
        guard let ratings = ratings else { return nil }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(ratings) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    // Helper function to decode otherRatings from JSON
    private func decodeRatings(from jsonString: String?) -> [MovieEntity.Rating]? {
        guard let jsonString = jsonString, let data = jsonString.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([MovieEntity.Rating].self, from: data)
    }
    
    // Save multiple movies to the database
    func saveMovies(_ movies: [MovieEntity]) {
        let insertQuery = """
        INSERT OR REPLACE INTO Movies (id, title, summary, posterUrl, imdbRating, imdbTotalRating, imdbVotes, genre, otherRatings) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            for movie in movies {
                sqlite3_bind_text(statement, 1, movie.id, -1, nil)
                sqlite3_bind_text(statement, 2, movie.title, -1, nil)
                sqlite3_bind_text(statement, 3, movie.summary, -1, nil)
                sqlite3_bind_text(statement, 4, movie.posterUrl?.absoluteString, -1, nil)
                sqlite3_bind_text(statement, 5, movie.imdbRating, -1, nil)
                sqlite3_bind_text(statement, 6, movie.imdbTotalRating, -1, nil)
                sqlite3_bind_text(statement, 7, movie.imdbVotes, -1, nil)
                sqlite3_bind_text(statement, 8, movie.genre, -1, nil)
                sqlite3_bind_text(statement, 9, encodeRatings(movie.otherRatings), -1, nil)
                
                if sqlite3_step(statement) != SQLITE_DONE {
                    print("Failed to insert movie: \(String(cString: sqlite3_errmsg(db)!))")
                }
                sqlite3_reset(statement)
            }
        } else {
            print("Failed to prepare insert statement: \(String(cString: sqlite3_errmsg(db)!))")
        }
        
        sqlite3_finalize(statement)
    }
    
    // Fetch all movies from the database
    func fetchMovies() -> [MovieEntity] {
        let fetchQuery = "SELECT id, title, summary, posterUrl, imdbRating, imdbTotalRating, imdbVotes, genre, otherRatings FROM Movies ORDER BY dateAdded DESC;"
        var statement: OpaquePointer?
        var movies: [MovieEntity] = []
        
        if sqlite3_prepare_v2(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_text(statement, 0).flatMap { String(cString: $0) }
                let title = sqlite3_column_text(statement, 1).flatMap { String(cString: $0) }
                let summary = sqlite3_column_text(statement, 2).flatMap { String(cString: $0) }
                let posterUrl = sqlite3_column_text(statement, 3).flatMap { String(cString: $0) }
                let imdbRating = sqlite3_column_text(statement, 4).flatMap { String(cString: $0) }
                let imdbTotalRating = sqlite3_column_text(statement, 5).flatMap { String(cString: $0) } ?? "10"
                let imdbVotes = sqlite3_column_text(statement, 6).flatMap { String(cString: $0) }
                let genre = sqlite3_column_text(statement, 7).flatMap { String(cString: $0) }
                let otherRatingsJSON = sqlite3_column_text(statement, 8).flatMap { String(cString: $0) }

                
                let movie = MovieEntity(
                    id: id ?? "",
                    title: title,
                    summary: summary,
                    posterUrl: URL(string: posterUrl ?? ""),
                    imdbRating: imdbRating,
                    imdbTotalRating: imdbTotalRating,
                    imdbVotes: imdbVotes,
                    genre: genre,
                    otherRatings: decodeRatings(from: otherRatingsJSON)
                )
                
                movies.append(movie)
            }
        } else {
            print("Failed to prepare fetch statement: \(String(cString: sqlite3_errmsg(db)!))")
        }
        
        sqlite3_finalize(statement)
        return movies
    }
}


