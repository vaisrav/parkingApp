//
//  UserView.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    @State private var name = ""
    @State private var contactNumber = ""
    @State private var carPlateNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Contact Number", text: $contactNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Car Plate Number", text: $carPlateNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Update Profile") {
                    updateProfile()
                }
                
                Button("Delete Account") {
                    deleteAccount()
                }
            }
            .navigationTitle("User Profile")
        }
    }
    
    func updateProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let userData: [String: Any] = [
            "name": name,
            "contactNumber": contactNumber,
            "carPlateNumber": carPlateNumber
        ]
        
        Firestore.firestore().collection("users").document(userId).updateData(userData) { error in
            if let error = error {
                print("Failed to update user data: \(error.localizedDescription)")
            } else {
                print("User profile updated successfully!")
                // Optionally, navigate to another view or perform any other action
            }
        }
    }
    
    func deleteAccount() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(userId).delete { error in
            if let error = error {
                print("Failed to delete user data: \(error.localizedDescription)")
            } else {
                Auth.auth().currentUser?.delete { error in
                    if let error = error {
                        print("Failed to delete user account: \(error.localizedDescription)")
                    } else {
                        print("User account deleted successfully!")
                        // Optionally, navigate to the login view or perform any other action
                    }
                }
            }
        }
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
