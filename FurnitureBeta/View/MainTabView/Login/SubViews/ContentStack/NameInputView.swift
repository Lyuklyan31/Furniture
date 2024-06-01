import SwiftUI

struct NameInputView: View {
    @Binding var name: String
    let imageSize: CGFloat

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .placeholder(when: name.isEmpty) {
                    Text("Name")
                        .foregroundColor(.white)
                        .bold()
                }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
        }
        .frame(width: imageSize)
    }
}
