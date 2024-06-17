import SwiftUI

struct LinkPhone: View {
    @ObservedObject var viewModel: MeViewModel
    @ObservedObject var phoneViewModel = AuthenticationPhoneViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isLingedWithPhone: Bool = false
    var body: some View {
        VStack {
            Text("Link Your Phone")
                .bold()
            

            PhoneAuthView(viewModel: phoneViewModel)
            
            
            OTPline(viewModel: phoneViewModel)
            
            ButtonLink(viewModel: viewModel, buttonName: "Link Phone", systemImageName: "phone", isLinked: viewModel.isLingedWithPhone) {
                try await linkPhoneAccount()
                await viewModel.checkProviders()
                dismiss()
            }
            .disabled(viewModel.isLingedWithPhone == true)
        }
    }
    func linkPhoneAccount() async throws {
        let verificationID = phoneViewModel.verificationID
        let verificationCODE = phoneViewModel.otpField
        viewModel.changePhoneNumber(text: phoneViewModel.phoneNumber)
        self.viewModel.authUser = try await AuthennticationManager.shared.linkPhone(verificationID: verificationID, verificationCODE: verificationCODE)
    }
}
