
import SwiftUI
import Kingfisher

struct CategorySubView: View {
    let item: Product

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageSize = adaptiveSize(for: screenWidth)

        VStack {
            if let firstPhotoURL = item.photoForPreview,
               let url = URL(string: firstPhotoURL) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(11)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .clipped()
            }
            
            HStack {
                Text("\(item.name)")
                    .font(.headline)
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            
            HStack {
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.headline)
                    .bold()
                
                Spacer()
            }
        }
        .padding()
    }
    func adaptiveSize(for screenWidth: CGFloat) -> CGFloat {
        if screenWidth > 500 {
            return 166
        } else {
            return screenWidth * 0.45
        }
    }
}
