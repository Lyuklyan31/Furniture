import SwiftUI

struct HomeSubView: View {
    enum FilterType {
        case newArrivals, popularItems, reducedPrices
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 130))
    ]
    
    let filter: FilterType
    var products: [Product]
    
    var title: String {
        switch filter {
        case .newArrivals:
            return "New arrivals"
        case .popularItems:
            return "Popular items"
        case .reducedPrices:
            return "Reduced prices"
        }
    }
    
    var filteredProducts: [Product] {
        switch filter {
        case .reducedPrices:
            return products.filter { $0.hasDiscount == true }
        case .newArrivals:
            return []
        case .popularItems:
            return []
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(filteredProducts) { item in
                    NavigationLink(destination: DetailFurnitureView(furniture: item)) {
                        CategorySubView(name: item.name, price: item.price, photoURL: item.photoForPreview)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}
