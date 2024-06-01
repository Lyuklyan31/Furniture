import SwiftUI

struct CurrentPhoneOrEmail: View {
    
    @ObservedObject var viewModel: AuthViewModel
    @Binding var currentShowingView: String
    @Binding var currentPhoneOrEmail: String
    
    var body: some View {
        if(currentPhoneOrEmail == "Phone") {
            InputPhone(viewModel: viewModel, currentViewShowing: $currentShowingView)
                .transition(.move(edge: .trailing))
            
            InputOTPCode(currentViewShowing: $currentShowingView, viewModel: viewModel)
                .transition(.move(edge: .trailing))
        } else {
            InputEmail(viewModel: viewModel, currentViewShowing: $currentShowingView)
                .transition(.move(edge: .leading))
        }
    }
}
