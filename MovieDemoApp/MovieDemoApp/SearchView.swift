//
//  SearchView.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var infoMessage: String? = nil // Holds info or error messages

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
        VStack {
            // Search Bar
            TextField("Search movies...", text: $searchText)
                .padding(10)
                .background(Color("DarkSkyBlue").opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: searchText) { newValue in
                    if newValue.count < 3 {
                        infoMessage = "Please enter at least 3 characters."
                    } else {
                        infoMessage = nil
                        // Call search function here if needed
                    }
                }

            // Info Label
            if let message = infoMessage {
                Text(message)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            // Movie Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(1..<21, id: \.self) { index in
                        VStack {
                            Image("PlaceholderImage") // Replace with movie poster image or URL
                                .resizable()
                                .scaledToFill()
                                .frame(width: posterWidth(), height: posterWidth() * 3 / 2)
                                .cornerRadius(8)
                                .clipped()

                            Text("Movie Title \(index)") // Replace with movie title
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .background(Color.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    // Helper function to calculate poster width based on screen size
    private func posterWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let columnsCount = UIDevice.current.userInterfaceIdiom == .pad ? (screenWidth > UIScreen.main.bounds.height ? 5 : 3) : 2
        return (screenWidth - CGFloat(columnsCount + 1) * 16) / CGFloat(columnsCount)
    }
}

struct SearchMovieScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
