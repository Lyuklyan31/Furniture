import SwiftUI
import CoreData

struct ButtonBuy: View {
    @ObservedObject var detailFurnitureViewModel: DetailFurnitureViewModel
    var moc: NSManagedObjectContext
    
    var body: some View {
        Button {
            detailFurnitureViewModel.addToCart(moc: moc)
        } label: {
            Rectangle()
                .frame(height: 65)
                .cornerRadius(15)
                .foregroundColor(detailFurnitureViewModel.addedToCart ? Color.green : Color.blue)
                .padding()
                .overlay {
                    HStack {
                        Text(detailFurnitureViewModel.addedToCart ? "Added to Cart" : "Buy")
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                        Text(Image(systemName: detailFurnitureViewModel.addedToCart ? "checkmark.circle.fill" : "cart"))
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                    }
                }
        }
    }
}
