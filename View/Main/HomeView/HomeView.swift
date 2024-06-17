import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: DataViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    PromotionsSliderView(promotions: viewModel.promotions)
                    SpecialTileView(special: viewModel.special, products: viewModel.products)
                }
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}
