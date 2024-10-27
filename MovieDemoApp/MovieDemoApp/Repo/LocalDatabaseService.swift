//
//  LocalDatabaseService.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import Foundation
import SwiftData

class LocalDatabaseService: DatabaseServiceProtocol {
    private let context = PersistenceController.shared.container.viewContext
    
    func saveMovies(_ movies: [Movie]) {
        for movie in movies {
            let entity = MovieEntity(id: movie.id, title: movie.title, year: movie.year, poster: movie.poster)
            context.insert(entity)
        }
        
        enforceRecordLimit()
        saveContext()
    }
    
    func fetchMovies() -> [MovieEntity] {
        let request = MovieEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MovieEntity.dateAdded, ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
    
    func saveMovieDetail(_ movieDetail: MovieDetail) {
        let entity = MovieDetailEntity(
            id: movieDetail.id,
            title: movieDetail.title,
            year: movieDetail.year,
            genre: movieDetail.genre,
            director: movieDetail.director,
            plot: movieDetail.plot,
            poster: movieDetail.poster
        )
        context.insert(entity)
        
        enforceRecordLimit()
        saveContext()
    }
    
    func fetchMovieDetail(by id: String) -> MovieDetailEntity? {
        let request = MovieDetailEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch movie detail: \(error)")
            return nil
        }
    }
    
    private func enforceRecordLimit() {
        let fetchRequest = MovieEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MovieEntity.dateAdded, ascending: true)]
        
        do {
            let allRecords = try context.fetch(fetchRequest)
            if allRecords.count > 100 {
                let recordsToDelete = allRecords.prefix(allRecords.count - 100)
                for record in recordsToDelete {
                    context.delete(record)
                }
            }
        } catch {
            print("Failed to enforce record limit: \(error)")
        }
    }
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
