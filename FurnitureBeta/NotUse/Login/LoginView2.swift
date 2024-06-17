//import SwiftUI
//import Firebase
//
//struct LoginView: View {
//    @ObservedObject var fbManager: FirebaseManager
//
//    var body: some View {
//        let screenWidth = UIScreen.main.bounds.width
//        let imageSize = adaptiveSize(for: screenWidth)
//
//        ZStack {
//            BackgroundView()
//            ContentStackView(imageSize: imageSize, fbManager: fbManager)
//                .onAppear {
//                    fbManager.checkCurrentUser()
//                }
//        }
//    }
//}
//
//extension LoginView {
//    func adaptiveSize(for screenWidth: CGFloat) -> CGFloat {
//        if screenWidth > 500 {
//            return 350
//        } else {
//            return screenWidth * 0.9
//        }
//    }
//}
//
//
//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//            
//            ZStack(alignment: alignment) {
//                placeholder().opacity(shouldShow ? 1 : 0)
//                self
//            }
//        }
//}
