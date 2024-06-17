//
//  FavoriteView.swift
//  FurnitureBeta
//
//  Created by admin on 08.06.2024.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<FavoriteEntity>
    var product = DataViewModel()
    let columns = [GridItem(.adaptive(minimum: 130))]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(favorites) { item in
                    if let favoriteName = product.products.first(where: { $0.name == item.name }) {
                        NavigationLink {
                            DetailFurnitureView(furniture: favoriteName)
                        } label: {
                            CategorySubView(name: item.name ?? "", price: item.price, photoURL: item.photoForPreview)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorite")
    }
}

#Preview {
    FavoriteView()
}
