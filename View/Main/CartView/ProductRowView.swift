import SwiftUI
import Kingfisher

struct ProductRowView: View {
    let furniture: ProductEntity

    var body: some View {
        HStack {
            if let firstPhotoURL = furniture.photoForPreview,
               let url = URL(string: firstPhotoURL) {
                KFImage(url)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
            }

            VStack(alignment: .leading) {
                Text(furniture.name ?? "")
                    .font(.headline)
                Text("Color: \(furniture.selectedColor ?? "")")
                    .font(.subheadline)
                Text("Quantity: \(furniture.amount)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
            VStack {
                Text(String(furniture.price * Double(furniture.amount))) + Text("$")
            }
            .padding(.vertical, 8)
        }
    }
}
