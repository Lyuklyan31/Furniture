//
//  ButtonFavorite.swift
//  FurnitureBeta
//
//  Created by admin on 05.06.2024.
//
import CoreData
import SwiftUI

struct ButtonFavorite: View {
    @ObservedObject var detailFurnitureViewModel: DetailFurnitureViewModel
    var moc: NSManagedObjectContext
    
    @State private var colorRedHeart: Bool = false
    
    var body: some View {
        
        Button {
            withAnimation {
                colorRedHeart.toggle()
                if colorRedHeart {
                    detailFurnitureViewModel.addToFavorite(moc: moc)
                } else {
                    detailFurnitureViewModel.removeFromFavorite(moc: moc)
                }
            }
        } label: {
            Image(systemName: colorRedHeart ? "heart.fill" : "heart")
                .font(.system(size: 25))
                .foregroundColor(.red)
                .offset(y: 2)
                .padding(8)
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                }
                .background {
                    Circle()
                        .foregroundColor(.primary)
                        .opacity(0.3)
            }
        }
        .onAppear {
                   colorRedHeart = detailFurnitureViewModel.isFavorite(moc: moc)
               }
    }
}
