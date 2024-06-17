//import SwiftUI
//import Firebase
//
//struct LoginButtonsView: View {
//    let email: String
//    let password: String
//    let name: String
//    @Binding var signUpLogin: Bool
//    @ObservedObject var fbManager: FirebaseManager
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                if signUpLogin {
//                    fbManager.registNewUser(user: UserData(name: name, email: email, password: password))
//                } else {
//                    fbManager.login(user: UserData(name: name, email: email, password: password))
//                }
//            }) {
//                Text(signUpLogin ? "Sign up" : "Login")
//                    .bold()
//                    .frame(width: 200, height: 40)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .fill(LinearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
//                    )
//                    .foregroundColor(.white)
//                    .opacity(email.isEmpty || password.isEmpty ? 0.5 : 1)
//            }
//            .disabled(email.isEmpty || password.isEmpty)
//            
//            .padding(.top)
//
//            Button(action: {
//                signUpLogin.toggle()
//            }) {
//                Text(signUpLogin ? "Already have an account? Login" : "Don't have an account? Sign up")
//                    .bold()
//                    .foregroundColor(.white)
//            }
//            .padding(.top)
//        }
//    }
//}
