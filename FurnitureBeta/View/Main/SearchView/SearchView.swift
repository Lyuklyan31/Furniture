import SwiftUI

struct SearchView: View {

    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var dataViewModel: DataViewModel 

    var body: some View {
        NavigationView {
            ScrollView {
                SearchBarView(searchingText: $searchViewModel.searchingText)
                LazyVStack(spacing: 20) {
                    ForEach(searchViewModel.filteredCategory) { category in
                        NavigationLink(destination: FurnitureView(category: category, searchViewModel: searchViewModel)) {
                            СategoryAppearanceView(category: category)
                                .foregroundColor(Color(.label))
                        }
                    }
                }
            }
            .navigationTitle("Store")
        }
    }
}
