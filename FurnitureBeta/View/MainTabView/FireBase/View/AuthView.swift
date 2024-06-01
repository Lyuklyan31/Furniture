import SwiftUI
import UIKit

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    
    var body: some View {
        if(currentViewShowing == "login") {
            Login2View(viewModel: AuthViewModel(), currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            SignupView(viewModel: AuthViewModel(), currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
    }
}
