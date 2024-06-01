import SwiftUI

struct ChangeColorFurnitureView: View {
@Binding var selectedColor: String
var productDetails: [Product.ProductDetails]

var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(productDetails, id: \.self) { detail in
                ForEach(detail.color, id: \.self) { color in
                    if detail.color.count > 1 {
                        Button(action: {
                            self.selectedColor = color
                            
                        }) {
                            Circle()
                                .fill(getColorFromString(color))
                                .frame(width: 35, height: 35)
                                .overlay {
                                    if color == selectedColor {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                            .bold()
                                            .shadow(radius: 1)
                                    }
                                    Circle()
                                        .stroke(Color.secondary,lineWidth: 1)
                                }
                        }
                        .padding(5)
                    } else {
                        Circle()
                            .fill(getColorFromString(color))
                            .frame(width: 35, height: 35)
                            .padding(5)
                    }
                }
            }
        }
    }
}

func getColorFromString(_ colorName: String) -> Color {
    switch colorName {
    case "Red":
        return .red
    case "Green":
        return .green
    case "Blue":
        return .blue
    case "Yellow":
        return .yellow
    case "Orange":
        return .orange
    case "White":
        return .white
    case "Brown":
          return .brown
    default:
        return .black
    }
}
}
