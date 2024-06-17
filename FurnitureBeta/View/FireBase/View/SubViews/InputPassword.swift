import SwiftUI

struct InputPassword: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    @FocusState var isPassword: Bool
    @FocusState var isRepeatPassword: Bool
    @Binding var currentViewShowing: String
    @Binding var currentPhoneOrEmail: String
    var body: some View {
        if currentPhoneOrEmail != "Phone" {
        HStack {
            Image(systemName: "lock")
            SecureField("Password", text: $viewModel.password)
            .focused($isPassword)
            Spacer()
            
            if(viewModel.password.count != 0) {
                Image(systemName: viewModel.password.isValidPassword() ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.password.isValidPassword() ? .green : .red)
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(currentViewShowing == "login" ? .black.opacity(0.2) : .white.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 10)
                .trim(from: isPassword ? 0 : 1, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(currentViewShowing == "login" ? .black : .white)
                .animation(.easeInOut(duration: 0.7), value: isPassword)
        }
        .transition(.move(edge: .trailing))
        .padding(.horizontal)
        
        
        if(currentViewShowing != "login") {
            HStack {
                Image(systemName: "lock")
                SecureField("Please repeat your password", text: $viewModel.repeatPassword)
                    .focused($isRepeatPassword)
                Spacer()
                
                if(viewModel.password.count != 0) {
                    Image(systemName: viewModel.repeatPassword.isValidPassword() ? "checkmark" : "xmark")
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.repeatPassword.isValidPassword() ? .green : .red)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: isRepeatPassword ? 0 : 1, to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .animation(.easeInOut(duration: 0.7), value: isRepeatPassword)
            }
            .transition(.move(edge: .bottom))
            .padding(.horizontal)
            
        }
               
            
        
       
            if viewModel.showWarning {
                Text(viewModel.warningText)
                    .foregroundColor(.red)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                viewModel.showAlert = false
                            }
                        }
            }
        }
            
        
        
           
        
            if(currentViewShowing == "login") {
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        viewModel.showForgotPassword = true
                    }
                    .foregroundColor(.black)
                }
                .padding()
                
                
            }
        }
        
            
    }
        
}

