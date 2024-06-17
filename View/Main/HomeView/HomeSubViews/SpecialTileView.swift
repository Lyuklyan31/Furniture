
import SwiftUI
import Kingfisher

struct SpecialTileView: View {
    var special: [Special]
    var products: [Product]
    var body: some View {
        
        NavigationStack {
            ForEach(special) { specialItem in
                
                VStack {
                    HStack {
                        Text(specialItem.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        
                        NavigationLink(destination: HomeSubView(filter: filter(for: specialItem.name), products: products)) {
                            Text("See All ") + Text(Image(systemName: "chevron.right"))
                        }
                        .padding(.trailing)
                        .bold()
                    }
                    .padding(.horizontal)
                    Tile2(special: specialItem)
                }
            }
        }
    }
    
    private func filter(for specialName: String) -> HomeSubView.FilterType {
        switch specialName {
        case "New Arrivals":
            return .newArrivals
        case "Best Sellers":
            return .popularItems
        case "Sale":
            return .reducedPrices
        default:
            return .newArrivals
        }
    }
}
