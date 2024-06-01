import SwiftUI
import CoreData

class DetailFurnitureViewModel: ObservableObject {
    @Published var furniture: Product
    @Published var rating: Int = 5
    @Published var amount: Int = 1
    @Published var selectedColor: String
    @Published var price: Double = 0.0
    @Published var addedToCart: Bool = false
    
    init(furniture: Product) {
        self.furniture = furniture
        if let firstProductDetails = furniture.productDetails?.first,
           let firstColor = firstProductDetails.color.first {
            self.selectedColor = firstColor
        } else {
            self.selectedColor = "White"
        }
        self.price = furniture.price * Double(amount)
    }
    
    func updatePrice() {
        self.price = furniture.price * Double(amount)
    }
    
    func getPhotosForColor(color: String) -> [String] {
        switch color.lowercased() {
        case "white":
            return furniture.photos?.white ?? []
        case "blue":
            return furniture.photos?.blue ?? []
        case "red":
            return furniture.photos?.red ?? []
        case "brown":
            return furniture.photos?.brown ?? []
        case "yellow":
            return furniture.photos?.yellow ?? []
        default:
            return []
        }
    }
    
    func addToCart(moc: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND selectedColor == %@", furniture.name, selectedColor)
        let id = UUID()
        do {
            let existingProducts = try moc.fetch(fetchRequest)
            if let existingProduct = existingProducts.first {
                existingProduct.amount += Int16(amount)
            } else {
                let product = ProductEntity(context: moc)
                product.id = id
                product.name = furniture.name
                product.price = furniture.price
                product.selectedColor = selectedColor
                product.photoForPreview = furniture.photoForPreview
                product.amount = Int16(amount)
            }
            try moc.save()
            addedToCart = true
        } catch {
            print("Failed to add product: \(error)")
        }
    }
}
