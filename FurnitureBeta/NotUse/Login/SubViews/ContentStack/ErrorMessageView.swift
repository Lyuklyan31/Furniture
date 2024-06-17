import SwiftUI

struct ErrorMessageView: View {
    var errorMessage: String?

    var body: some View {
        if let errorMessage = errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        } else {
            EmptyView()
        }
    }
}
