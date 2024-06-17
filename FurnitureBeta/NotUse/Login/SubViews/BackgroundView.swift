import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.99)
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(
                    LinearGradient(colors: [.red.opacity(0.8), .pink.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width: 1200, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            BackgroundImagesView()
        }
        .ignoresSafeArea()
    }
}
