import SwiftUI

struct InputPassword: View {
    @ObservedObject var viewModel: AuthViewModel
    @FocusState var isEnabled: Bool
    @Binding var currentViewShowing: String
    var body: some View {
        
        HStack {
            Image(systemName: "lock")
            SecureField("Password", text: $viewModel.password)
            .focused($isEnabled)
            Spacer()
            
            if(viewModel.password.count != 0) {
                Image(systemName: viewModel.isValidPassword(viewModel.password) ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.isValidPassword(viewModel.password) ? .green : .red)
            }
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(currentViewShowing == "login" ? .black.opacity(0.2) : .white.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 10)
                .trim(from: isEnabled ? 0 : 1, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(currentViewShowing == "login" ? .black : .white)
                .animation(.easeInOut(duration: 0.7), value: isEnabled)
        }
        .padding(.horizontal)
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
