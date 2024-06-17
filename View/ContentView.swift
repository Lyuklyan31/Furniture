
import SwiftUI
import Firebase

struct ContentView: View {
    
@AppStorage("uid") var userID: String = ""
    
    var body: some View {
    
        if userID.isEmpty {
            AuthView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
