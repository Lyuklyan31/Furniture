import Foundation
import SwiftUI

class AllViewModel: ObservableObject {
    @Published var searchingText: String = ""
    
    @ObservedObject var viewModel: DataViewModel
    
    let columns = [GridItem(.adaptive(minimum: 130))]
    
    init(viewModel: DataViewModel) {
        self.viewModel = viewModel
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
}
