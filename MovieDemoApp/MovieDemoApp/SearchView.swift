//
//  SearchView.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel

    // Responsive columns based on device width
    var columns: [GridItem] {
        let columnCount: Int
        if UIDevice.current.userInterfaceIdiom == .pad {
            columnCount = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? 5 : 3 // iPad: 3 columns in portrait, 5 in landscape
        } else {
            columnCount = 2 // iPhone: 2 columns in portrait
        }
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: columnCount)
    }

    var body: some View {
        
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search movies...", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color("DarkSkyBlue").opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: viewModel.searchText) { newValue in
                        if newValue.count < 3 {
                            viewModel.infoMessage = "Please enter at least 3 characters."
                        } else {
                            viewModel.infoMessage = nil
                            // Call search function here if needed
                        }
                    }
                    .onSubmit {
                        Task { await viewModel.searchMovies() }
                    }

                // Info Label
                if let message = viewModel.infoMessage {
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // Movie Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                ZStack(alignment: .bottom) {
                                    MoviePosterView(imageUrl: movie.posterUrl, posterWidth: posterWidth())

                                    // Background for the text to improve visibility
                                    Text(movie.title ?? "")
                                        .font(.caption)
                                        .lineLimit(1)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.black.opacity(0.7)) // Semi-transparent black background
                                        .foregroundColor(.white)              // White text for contrast
                                        .cornerRadius(4)
                                        .padding(8) // Padding to position text slightly above the bottom edge
                                }

                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        
    }

    // Helper function to calculate poster width based on screen size
    private func posterWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let columnsCount = UIDevice.current.userInterfaceIdiom == .pad ? (screenWidth > UIScreen.main.bounds.height ? 5 : 3) : 2
        return (screenWidth - CGFloat(columnsCount + 1) * 16) / CGFloat(columnsCount)
    }
}

//struct SearchMovieScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
