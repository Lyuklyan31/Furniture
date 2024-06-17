import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit




struct AppleID: View {
    @StateObject private var viewModel = AuthAppleIDViewModel()
    @Binding var currentShowingView: String
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await viewModel.signInApple()
                    } catch {
                        print("error")
                    }
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: currentShowingView == "login" ? .white : .black)
                    .allowsHitTesting(false)
                    .frame(height: 40)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(currentShowingView == "login" ? .black : .white, lineWidth: 2)
                    }
                    .padding(.horizontal, 40)
            }
        }
    }
}
    
