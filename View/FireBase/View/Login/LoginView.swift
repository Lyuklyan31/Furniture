import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var viewModel = SignInEmailViewModel()
    @ObservedObject var phoneViewModel = AuthenticationPhoneViewModel()
    
    @State private var showAlert: Bool = false
    @State private var currentPhoneOrEmail: String = "Phone"
    @Binding var currentShowingView: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HeaderWelcome(currentShowingView: $currentShowingView)
                    
                    ScrollButtons(currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                    
                    CurrentPhoneOrEmail(viewModel: viewModel, phoneViewModel: phoneViewModel, currentShowingView: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                    
                    InputPassword(viewModel: viewModel, currentViewShowing: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                    
                    ButtonChangeScreen(currentViewShowing: $currentShowingView)
                    
                    Button {
                        if currentPhoneOrEmail == "Phone" {
                            Task {
                                do {
                                    try await phoneViewModel.signIn()
                                } catch {
                                    showAlert = true
                                    print(error)
                                }
                            }
                        } else {
                            Task {
                                do {
                                    try await viewModel.signIn()
                                } catch {
                                    print(error)
                                }
                            }
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
                    .padding()
                    
                    Text("Or Sign in with?")
                        .font(.headline)
                        .bold()
                    
                    VStack {
                        AppleID(currentShowingView: $currentShowingView)
                        Google(currentShowingView: $currentShowingView)
                        Anonymous()
                    }
                    .padding()
                }
                .sheet(isPresented: $viewModel.showForgotPassword, content: {
                    ForgotPassword(viewModel: viewModel, currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                        .presentationDetents([.fraction(0.4)])
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Incorrect OTP code"), message: Text("The entered OTP code is incorrect. Please try again."), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
