//
//  SignInView.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import SwiftUI
import Firebase

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Sign In") {
                    signIn()
                }
            }
            .navigationTitle("Sign In")
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
            } else {
                print("User signed in successfully!")
                // Optionally, navigate to another view or perform any other action
            }
        }
    }
}

