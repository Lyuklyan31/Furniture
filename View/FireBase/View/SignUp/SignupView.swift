import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @ObservedObject var viewModel = SignInEmailViewModel()
    @ObservedObject var phoneViewModel = AuthenticationPhoneViewModel()
    @State var isEnabled = false
    @Binding var currentShowingView: String
    @State private var currentPhoneOrEmail: String = "Phone"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HeaderWelcome(currentShowingView: $currentShowingView)
                    ScrollButtons(currentPhoneOrEmail: $currentPhoneOrEmail, currentViewShowing: $currentShowingView)
                    CurrentPhoneOrEmail(viewModel: viewModel, phoneViewModel: phoneViewModel, currentShowingView: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                    InputPassword(viewModel: viewModel, currentViewShowing: $currentShowingView, currentPhoneOrEmail: $currentPhoneOrEmail)
                    ButtonChangeScreen(currentViewShowing: $currentShowingView)
                    
                    Button {
                        if(currentPhoneOrEmail == "Email") {
                            Task {
                                do {
                                    if(viewModel.password != viewModel.repeatPassword) {
                                        viewModel.warningText = "Passwords do not match"
                                        viewModel.showWarning = true
                                    } else {
                                        viewModel.title = "Success!"
                                        viewModel.message = "You have successfully registered. You can now log in."
                                        viewModel.showAlert = true
                                        
                                        try await  viewModel.signUp()
                                        
                                        viewModel.password = ""
                                        viewModel.email = ""
                                        viewModel.repeatPassword = ""
                                        
                                    }
                                } catch {
                                    viewModel.message = "Registration failed. Please try again."
                                    print(error)
                                }
                            }
                            
                            
                        } else {
                                Task {
                                    do {
                                        try await phoneViewModel.signIn()
                                        viewModel.title = "Success!"
                                        viewModel.message = "You have successfully registered."
                                    } catch {
                                        viewModel.warningText = "WORNING"
                                        viewModel.showWarning = true
                                        print(error)
                                    
                                }
                            }
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
                    
                    Text("Or Sign in with?")
                        .font(.headline)
                        .bold()
                        .padding()
                    
                    VStack {
                        AppleID(currentShowingView: $currentShowingView)
                        Google(currentShowingView: $currentShowingView)
                    }
                    .padding()
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("\(viewModel.title)"), message: Text("\(viewModel.message)"), dismissButton: .default(Text("OK")))
            }
        }
    }
}



