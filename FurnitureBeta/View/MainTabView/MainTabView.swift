import SwiftUI

struct MainTabView: View {

    @StateObject private var searchViewModel = SearchViewModel(viewModel: DataViewModel())
    @StateObject private var  allViewModel = AllViewModel(viewModel: DataViewModel())
    @StateObject private var  dataViewModel = DataViewModel()
    var body: some View {
        ZStack {
            TabView {
                HomeView(viewModel: DataViewModel())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SearchView(searchViewModel: searchViewModel, dataViewModel: dataViewModel)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                AllView(allViewModel: AllViewModel(viewModel: dataViewModel))
                    .tabItem {
                        Label("Shop all", systemImage: "bag")
                    }
                
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
                
                MeView(viewModel: AuthViewModel())
                    .tabItem {
                        Label("Acount", systemImage: "person")
                    }
            }
            .accentColor(.indigo)
        }
        .ignoresSafeArea()
    }
}

