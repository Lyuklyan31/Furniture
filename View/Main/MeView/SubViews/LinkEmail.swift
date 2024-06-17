import SwiftUI

struct LinkEmail: View {
    @ObservedObject var viewModel: MeViewModel
    @State private var repeatPassword: String = ""
    @FocusState private var isEnabled: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isRepeatPasswordFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Link Your Email")
                .bold()
            
            HStack {
                Image(systemName: "mail")
                TextField("Email", text: $viewModel.email)
                    .focused($isEnabled)
                
                if !viewModel.email.isEmpty {
                    Image(systemName: viewModel.email.isValidEmail() ? "checkmark" : "xmark")
                        .foregroundColor(viewModel.email.isValidEmail() ? .green : .red)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: 0, to: isEnabled ? 1 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.primary)
                    .scaleEffect(x: -1, y: 1)
                    .animation(.easeInOut(duration: 0.7), value: isEnabled)
            }
            .padding()
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $viewModel.password)
                    .focused($isPasswordFocused)
                
                if !viewModel.password.isEmpty {
                    Image(systemName: viewModel.password.isValidPassword() ? "checkmark" : "xmark")
                        .foregroundColor(viewModel.password.isValidPassword() ? .green : .red)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: 0, to: isPasswordFocused ? 1 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.primary.opacity(0.2))
                    .animation(.easeInOut(duration: 0.7), value: isPasswordFocused)
            }
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Repeat Password", text: $repeatPassword)
                    .focused($isRepeatPasswordFocused)
                
                if !repeatPassword.isEmpty {
                    Image(systemName: repeatPassword.isValidPassword() ? "checkmark" : "xmark")
                        .foregroundColor(repeatPassword.isValidPassword() ? .green : .red)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .trim(from: 0, to: isRepeatPasswordFocused ? 1 : 0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.primary)
                    .animation(.easeInOut(duration: 0.7), value: isRepeatPasswordFocused)
            }
            .padding(.horizontal)
            
            ButtonLink(viewModel: viewModel, buttonName: "Link Email", customImageName: "email", isLinked: viewModel.isLingedWithEmail) {
                try await viewModel.linkEmailAccount()
                await viewModel.checkProviders()
                dismiss()
            }
            .disabled(viewModel.isLingedWithEmail == true)
        }
    }
}
