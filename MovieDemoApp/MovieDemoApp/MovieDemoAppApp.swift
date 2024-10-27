//
//  MovieDemoAppApp.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

@main
struct MovieDemoAppApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var searchVM = SearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                SearchView()
                    .environmentObject(authViewModel)
                    .environmentObject(searchVM)
            }
            else {
                HomeScreen()
                    .environmentObject(authViewModel)
            }
        }
    }
}
