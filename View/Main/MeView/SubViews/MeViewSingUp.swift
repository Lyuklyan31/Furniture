
import SwiftUI

struct MeViewSingUp: View {
    @ObservedObject var viewModel: MeViewModel
    var body: some View {
        VStack {
            //if(viewModel.isLingedWithEmail == false) {
            ButtonLink(viewModel: viewModel, buttonName: "Link Google Account", customImageName: "Google", isLinked: viewModel.isLinkedWithGoogle) {
                    try await viewModel.linkGoogleAccount()
                    await viewModel.checkProviders()
                }
           // }
            ButtonLink(viewModel: viewModel, buttonName: " Link Apple Account", systemImageName: "apple.logo", isLinked: viewModel.isLinkedWithApple) {
                try await viewModel.linkAppleAccount()
                await viewModel.checkProviders()
            }
            
           // if(viewModel.isLinkedWithGoogle == false) {
            ButtonLink(viewModel: viewModel, buttonName: "Link Email Account", customImageName: "email", isLinked: viewModel.isLingedWithEmail) {
                    await viewModel.checkProviders()
                }
           // }
            
            ButtonLink(viewModel: viewModel, buttonName: "Link Phone Account", systemImageName: "phone",isLinked: viewModel.isLingedWithPhone) {
                try await viewModel.linkPhoneAccount()
                await viewModel.checkProviders()
            }
            
        }
        .multilineTextAlignment(.leading)
    
    }
}
