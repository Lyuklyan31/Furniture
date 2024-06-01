//
//  CartView.swift
//  FurnitureBeta
//
//  Created by admin on 30.04.2024.
//

import SwiftUI
import Kingfisher

struct CartView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var products: FetchedResults<ProductEntity>
    @State private var showingSheet = false
    var body: some View {
        if products.isEmpty {
            Text("Your Cart is empty(")
        } else {
            NavigationView {
                VStack {
                    List {
                        ForEach(products) { furniture in
                            ProductRowView(furniture: furniture)
                        }
                        .onDelete(perform: removeRows)
                    }
                    
                    Button(action: {
                        showingSheet = true
                    }) {
                        Text("Place an Order")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
              
            }
            .navigationTitle("Cart")
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        for index in offsets {
            let product = products[index]
            moc.delete(product)
        }
        do {
            try moc.save()
        } catch {
            print("Failed to save changes: \(error)")
        }
    }
}

