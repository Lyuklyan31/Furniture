//import SwiftUI
//
//struct PasswordInputView: View {
//    @Binding var password: String
//    let imageSize: CGFloat
//
//    var body: some View {
//        VStack {
//            SecureField("Password", text: $password)
//                .foregroundColor(.white)
//                .textFieldStyle(.plain)
//                .placeholder(when: password.isEmpty) {
//                    Text("Password")
//                        .foregroundColor(.white)
//                        .bold()
//                }
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(.white)
//        }
//        .frame(width: imageSize)
//    }
//}
