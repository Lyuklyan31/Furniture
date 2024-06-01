import SwiftUI
import FirebaseAuth

struct Login2View: View {
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var currentPhoneOrEmail: String = "Phone"
    @Binding var currentShowingView: String
    
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HeaderWelcome(currentShowingView: $currentShowingView)
                ScrollButtons(currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                CurrentPhoneOrEmail(viewModel: viewModel, currentShowingView: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                InputPassword(viewModel: viewModel, currentViewShowing: $currentShowingView)
                ButtonChangeScreen(currentViewShowing: $currentShowingView)
                
                Button {
                    if currentPhoneOrEmail == "Phone" {
                        viewModel.verifyOTPCode()
                        viewModel.signInPhone()
                    } else {
                        viewModel.signIn()
                    }
                    
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                        )
                        .padding(.horizontal)
                }

            }
            .sheet(isPresented: $viewModel.showForgotPassword, content: {
                ForgotPassword(viewModel: viewModel, currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                    .presentationDetents([.fraction(0.3)])
            })
            .alert(viewModel.errorMassange, isPresented: $viewModel.showError) { }
        }
    }
}
