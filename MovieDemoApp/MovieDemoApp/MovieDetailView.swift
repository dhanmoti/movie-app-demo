//
//  MovieDetailView.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Blurred Poster Background with Diagonal Cut
                ZStack(alignment: .top) {
                    GeometryReader { geometry in
                        ZStack(alignment: .bottomLeading) {
                            MoviePosterView(imageUrl: viewModel.movie.posterUrl, posterWidth: geometry.size.width)
                                .clipped()
                                .blur(radius: 10)
                                .frame(height: 300)
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                                )
                            
                            // Diagonal Clipping Shape
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                                .clipShape(DiagonalClipShape())
                        }
                    }


                    VStack(alignment: .leading) {
                        MoviePosterView(imageUrl: viewModel.movie.posterUrl, posterWidth: posterWidth())
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .padding(.top, 32)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    
                }
                

                VStack(alignment: .leading, spacing: 32) {
                    // Star Rating and Value
                    HStack {
                        StarRatingView(rating: viewModel.starRating) // Custom view for stars, replace with your implementation
                        Text("\(viewModel.movie.imdbRating ?? "N/A") / 10")
                            .font(.subheadline)
                            .foregroundColor(Color("DarkSkyBlue"))
                    }
                    .padding(.leading, 16)

                    // Title and Genre
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.movie.title ?? "Untitled Movie")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text(viewModel.movie.genre ?? "")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.leading, 16)

                    // Plot Summary
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Plot Summary")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text(viewModel.movie.summary ?? "")
                            .font(.body)
                            .foregroundColor(Color.gray.opacity(0.7))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 16)

                    // Other Ratings Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Other Ratings")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)

                        // Horizontal Scroll View for Additional Ratings
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach((viewModel.movie.otherRatings ?? []), id: \.source) { rating in
                                    VStack(alignment: .trailing, spacing: 16) {
                                        Text(rating.source)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(height: 72)
                                        Text(rating.value ?? "")
                                            .font(.headline)
                                            .foregroundColor(Color("DarkSkyBlue"))
                                    }
                                    .padding(8)
                                    .frame(width: 180)
                                    .background(Color.black.opacity(0.1)) // Optional: Add a background to see the shadow better
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)) // Clips to shape for better shadow rendering
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .onAppear {
            Task {
                await viewModel.loadMovie()
            }
        }
    }

    // Helper function to calculate poster width
    private func posterWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let columnsCount = UIDevice.current.userInterfaceIdiom == .pad ? 3 : 2
        return (screenWidth - CGFloat(columnsCount + 1) * 16) / CGFloat(columnsCount)
    }
}

// Custom Shape for Diagonal Clipping
struct DiagonalClipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))                        // Start at the top-left corner
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.33))  // Go to a point 33% down on the right edge
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))  // Bottom-right corner
        path.addLine(to: CGPoint(x: 0, y: rect.height))           // Bottom-left corner
        path.closeSubpath()
        return path
    }
}


// Placeholder StarRatingView
struct StarRatingView: View {
    var rating: Double
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .foregroundColor(Color("DarkSkyBlue"))
            }
        }
    }
}

