//
//  ProductDetailsView.swift
//  FurnitureBeta
//
//  Created by admin on 08.05.2024.
//

import SwiftUI

struct ProductDetailsView: View {
    @State var details = [Product.ProductDetails]()
    
    var body: some View {
        VStack {
            ForEach(details, id: \.self) { detail in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Room Type")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(detail.roomType)
                    }
                    HStack {
                        Text("Color")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(detail.color.joined(separator: ", "))
                    }
                    HStack {
                        Text("Material")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(detail.material)
                    }
                    HStack {
                        Text("Dimensions")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(detail.dimensions)
                    }
                    HStack {
                        Text("Weight")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(detail.weight)
                    }
                }
                .padding()
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
        .font(.title2)
        .padding()
    }
}
