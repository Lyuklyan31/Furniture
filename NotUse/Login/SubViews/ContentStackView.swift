//import SwiftUI
//
//struct ContentStackView: View {
//    let imageSize: CGFloat
//    let fbManager: FirebaseManager
//    
//    @State private var email = ""
//    @State private var password = ""
//    @State private var signUpLogin = false
//    @State private var name = ""
//    @Environment(\.dismiss) var dismiss
//    var body: some View {
//        VStack {
//            Text("Welcome")
//                .foregroundColor(.white)
//                .font(.system(size: 40, weight: .bold, design: .rounded))
//            if signUpLogin {
//                NameInputView(name: $name, imageSize: imageSize)
//            }
//            EmailInputView(email: $email, imageSize: imageSize)
//            PasswordInputView(password: $password, imageSize: imageSize)
//            ErrorMessageView(errorMessage: fbManager.errorMessage)
//           
//                LoginButtonsView(email: email, password: password, name: name, signUpLogin: $signUpLogin, fbManager: fbManager)
//                    .padding(.top, 60)
//                  
//        }
//    }
//}
