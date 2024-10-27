//
//  MoviePosterView.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct MoviePosterView: View {
    let imageUrl: URL?
    let posterWidth: CGFloat
    
    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                // Placeholder while loading
                Image("PlaceholderImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: posterWidth)
                    .cornerRadius(8)
                    .clipped()
                
            case .success(let image):
                // Successfully loaded image
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: posterWidth)
                    .cornerRadius(8)
                    .clipped()
                
            case .failure:
                // Error loading image, fallback to placeholder
                Image("PlaceholderImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: posterWidth)
                    .cornerRadius(8)
                    .clipped()
            @unknown default:
                // Error loading image, fallback to placeholder
                Image("PlaceholderImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: posterWidth)
                    .cornerRadius(8)
                    .clipped()
            }
        }
    }
    
}
