//
//  HomeScreen.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            // Top Image (One third of the screen height)
            Image("HomeScreenImg")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height / 3)
                .clipped()

            Spacer()

            // Title and Subtitle
            VStack(spacing: 8) { // Default spacing for better alignment
                Text("Access more with an account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkSkyBlue"))

                Text("Login to an account so you could access more features")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            .multilineTextAlignment(.center)
            .padding()

            Spacer()

            // Bottom Buttons
            VStack(spacing: 16) {
                // Login Button
                Button(action: {
                    // Login action here
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("DarkSkyBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                // Sign Up Button
                Button(action: {
                    // Sign up action here
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color("DarkSkyBlue"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("DarkSkyBlue"), lineWidth: 2)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
