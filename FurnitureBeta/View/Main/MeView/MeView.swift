
import SwiftUI

struct MeView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out")
            }
        }
    }
}
