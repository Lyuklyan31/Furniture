
import SwiftUI

struct AllView: View {
    @ObservedObject var allViewModel: AllViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SearchBarView(searchingText: $allViewModel.searchingText)
                LazyVGrid(columns: allViewModel.columns) {
                    ForEach(allViewModel.filteredProducts) { item in
                        NavigationLink(destination: DetailFurnitureView(furniture: item)) {
                            CategorySubView(item: item)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("All")
        }
    }
}
