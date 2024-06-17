import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchingText: String = ""
    
    var viewModel: DataViewModel
    
    let columns = [GridItem(.adaptive(minimum: 130))]
    
    init(viewModel: DataViewModel) {
        self.viewModel = viewModel
    }
 
    
    var filteredCategory: [Category] {
            if searchingText.isEmpty {
                return viewModel.category
            } else {
                let searchText = searchingText.lowercased()
                return viewModel.category.filter { $0.name.lowercased().contains(searchText) }
            }
        }
    
    var filteredProducts: [Product] {
        if searchingText.isEmpty {
            return viewModel.products
        } else {
            let searchText = searchingText.lowercased()
            return viewModel.products.filter { product in
                product.name.lowercased().contains(searchText)
            }
        }
    }
    
    
    func getProducts(for category: Category, allProducts: [Product]) -> [Product] {
        return allProducts.filter { product in
            guard let productDetails = product.productDetails else {
                return false
            }
            let roomTypes = productDetails.flatMap { $0.roomType.components(separatedBy: ",") }
            
            return roomTypes.contains { roomType in
                return roomType.trimmingCharacters(in: .whitespaces) == category.name.trimmingCharacters(in: .whitespaces)
            }
        }
    }

}
