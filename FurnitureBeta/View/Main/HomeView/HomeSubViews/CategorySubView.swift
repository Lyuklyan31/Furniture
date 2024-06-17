import SwiftUI
import Kingfisher

struct CategorySubView: View {
    let name: String
    let price: Double
    let photoURL: String?

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageSize = adaptiveSize(for: screenWidth)

        VStack {
            if let photoURL = photoURL, let url = URL(string: photoURL) {
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
                Text(name)
                    .bold()
                    .lineLimit(1)
                Spacer()
            }
            
            HStack {
                Text("$\(String(format: "%.2f", price))")
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
