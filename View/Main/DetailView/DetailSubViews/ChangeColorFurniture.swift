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
        switch colorName.lowercased() {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "white":
            return .white
        case "brown":
            return .brown
        case "black":
            return .black
        case "purple":
            return .purple
        case "gray":
            return .gray
        case "pink":
            return .pink
        case "cyan":
            return .cyan
        case "magenta":
            return Color(red: 1.0, green: 0.0, blue: 1.0)
        case "lime":
            return Color(red: 0.75, green: 1.0, blue: 0.0)
        default:
            return .black
            
        }

    }
}
