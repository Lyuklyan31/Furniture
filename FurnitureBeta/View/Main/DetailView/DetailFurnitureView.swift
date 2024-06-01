import SwiftUI
import Kingfisher

struct DetailFurnitureView: View {
    @ObservedObject var detailFurnitureViewModel: DetailFurnitureViewModel
    @Environment(\.managedObjectContext) var moc
    
    init(furniture: Product) {
        self.detailFurnitureViewModel = DetailFurnitureViewModel(furniture: furniture)
    }

    var body: some View {
        let photos = detailFurnitureViewModel.getPhotosForColor(color: detailFurnitureViewModel.selectedColor)
        ScrollView {
            TabView {
                ForEach(photos, id: \.self) { photo in
                    KFImage(URL(string: photo))
                        .resizable()
                        .scaledToFill()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 375)
            .cornerRadius(13)
            .shadow(radius: 7)

            HStack {
                Text(detailFurnitureViewModel.furniture.name)
                    .font(.title)
                    .padding()
                Spacer()
            }

            HStack {
                StarRatingView(rating: $detailFurnitureViewModel.rating)
                                   .shadow(radius: 1)
                Spacer()
                ChangeColorFurnitureView(selectedColor: $detailFurnitureViewModel.selectedColor, productDetails: detailFurnitureViewModel.furniture.productDetails ?? [])
            }
            .padding(.horizontal)

            HStack {
                Text("$\(String(format: "%.2f", detailFurnitureViewModel.price))")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .bold()
                    .padding()
                Spacer()
                AmountFurnitureView(amount: $detailFurnitureViewModel.amount)
                    .padding(.horizontal)
            }

            HStack {
                Text("Product Details")
                    .font(.title)
                    .padding(5)
                Spacer()
            }
            ProductDetailsView(details: detailFurnitureViewModel.furniture.productDetails ?? [])
        }
        
        VStack {
            ButtonBuy(detailFurnitureViewModel: detailFurnitureViewModel, moc: moc)
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(detailFurnitureViewModel.furniture.name)
        .onChange(of: detailFurnitureViewModel.amount) { _ in
            detailFurnitureViewModel.updatePrice()
        }
    }
}
