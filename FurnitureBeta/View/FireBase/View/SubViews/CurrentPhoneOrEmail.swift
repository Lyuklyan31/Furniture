import SwiftUI

struct CurrentPhoneOrEmail: View {
    
    @ObservedObject var viewModel: SignInEmailViewModel
    @ObservedObject var phoneViewModel: AuthenticationPhoneViewModel
    
    @Binding var currentShowingView: String
    @Binding var currentPhoneOrEmail: String

    
    var body: some View {
        if(currentPhoneOrEmail == "Phone") {
            PhoneAuthView(viewModel: phoneViewModel)
                .transition(.move(edge: .trailing))
            OTPline(viewModel: phoneViewModel)
                .transition(.move(edge: .leading))
        } else {
            InputEmail(viewModel: viewModel, currentViewShowing: $currentShowingView)
                .transition(.move(edge: .leading))
        }
    }
}
