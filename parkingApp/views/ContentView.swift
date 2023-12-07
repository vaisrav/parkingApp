import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        TabView {
            SignupView()
                .tabItem {
                    Label("Sign Up", systemImage: "person.fill")
                }
            
            SigninView()
                .tabItem {
                    Label("Sign In", systemImage: "person.fill")
                }
        }
        .onAppear(perform: {
            FirebaseApp.configure()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
