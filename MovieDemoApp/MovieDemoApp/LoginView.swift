//
//  LoginView.swift
//  MovieDemoApp
//
//  Created by Dhan Moti on 27/10/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode // Allows us to go back to the previous screen

    var body: some View {
        VStack {
            // Back Button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Go back to the previous screen
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("DarkSkyBlue")) // Color matches theme
                        .font(.title2)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            .padding(.bottom, 64)


            // Title and Subtitle
            VStack(spacing: 8) {
                Text("Welcome back 👋 ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("DarkSkyBlue"))
                Text("I am so happy to see you again. You can continue to login for more features")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            .multilineTextAlignment(.center)
            .padding()

            // Text Fields for Username and Password
            VStack(spacing: 16) {
                TextField("Username", text: .constant("")) // Placeholder for username field
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("Password", text: .constant("")) // Placeholder for password field
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }

            Spacer()

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
            .padding(.horizontal)
            .padding(.bottom, 16)

            // Sign Up Link
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    // Sign up action here
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color("DarkSkyBlue")) 
                }
            }
            .padding(.bottom, 32)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
