import SwiftUI
import Kingfisher

struct FurnitureView: View {
    var category: Category
    @ObservedObject var searchViewModel: SearchViewModel

    var body: some View {
        ScrollView {
            SearchBarView(searchingText: $searchViewModel.searchingText)
            LazyVGrid(columns: searchViewModel.columns) {
                ForEach(searchViewModel.getProducts(for: category, allProducts: searchViewModel.viewModel.products)) { item in
                    NavigationLink(destination: DetailFurnitureView(furniture: item)) {
                        CategorySubView(item: item)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Furniture")
    }
}
