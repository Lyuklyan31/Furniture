
import SwiftUI
import Firebase

struct ContentView: View {
    //favorite
    
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
      
        
            
            if userID == "" {
                AuthView()
            } else {
                MainTabView()
            }
            
            
        
    }
}
#Preview {
    ContentView()
}
