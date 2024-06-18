import SwiftUI
import Kingfisher

struct ProductRowView: View {
    @State private var quantity: Int
    let furniture: ProductEntity
    @Environment(\.managedObjectContext) private var moc
    
    init(furniture: ProductEntity) {
        self.furniture = furniture
        self._quantity = State(initialValue: Int(furniture.amount))
    }
    
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
                    .offset(x: -6)
            }
            
            
            VStack(alignment: .leading) {
                Text(furniture.name ?? "")
                    .font(.headline)
                    .lineLimit(2)
                Text("Color: \(furniture.selectedColor ?? "")")
                    .font(.subheadline)
                Text("Quantity: \(quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                Text(String(format: "%.2f", furniture.price * Double(quantity))) + Text("$")
                
                
                Stepper("", value: $quantity, in: 1...99)
                    .labelsHidden()
                    .frame(width: 30)
                    .onChange(of: quantity, perform: { _ in
                        saveChanges()
                    })
            }
            .padding(.vertical, 8)
        }
        
    }
    
    private func saveChanges() {
        furniture.amount = Int16(quantity)
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
