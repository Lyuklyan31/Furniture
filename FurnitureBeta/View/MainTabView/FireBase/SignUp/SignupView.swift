import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    @Binding var currentShowingView: String
    @State private var currentPhoneOrEmail: String = "Phone"
   
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HeaderWelcome(currentShowingView: $currentShowingView)
                ScrollButtons(currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                CurrentPhoneOrEmail(viewModel: viewModel, currentShowingView: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                InputPassword(viewModel: viewModel, currentViewShowing: $currentShowingView)
                ButtonChangeScreen(currentViewShowing: $currentShowingView)
                
                
                Button {
                    
                    if(currentPhoneOrEmail == "Email") {
                        viewModel.signUp()
                    } else {
                        viewModel.signUpPhone()
                    }
                    
                } label: {
                    Text("Create New Account")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                        )
                        .padding(.horizontal)
                }

            }
        }
    }
}
