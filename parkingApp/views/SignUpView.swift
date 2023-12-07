import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var contactNumber = ""
    @State private var carPlateNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Contact Number", text: $contactNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Car Plate Number", text: $carPlateNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Sign Up") {
                    signUp()
                }
            }
            .navigationTitle("Sign Up")
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print("Sign-up error: \(error.localizedDescription)")
            } else {
                guard let userId = authResult?.user.uid else { return }
                print(userId)
                let userData: [String: Any] = [
                    "name": name,
                    "contactNumber": contactNumber,
                    "carPlateNumber": carPlateNumber
                ]
                
                Firestore.firestore().collection("users").document(userId).setData(userData) { error in
                    if let error = error {
                        print("Failed to save user data: \(error.localizedDescription)")
                    } else {
                        print("User signed up successfully!")

                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: ContentView())
                            let welcomeView = AddParkingView()
                            let hostingController = UIHostingController(rootView: welcomeView)
                            window.rootViewController?.present(hostingController, animated: true, completion: nil)
                        }
                    }
                }


            }
        }
    }

}
