//
//  SearchView.swift
//  FurnitureBeta
//
//  Created by admin on 30.04.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchingText: String
  
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchingText.isEmpty ?
                    Color.secondary : Color.black
                )
            TextField("Search...", text: $searchingText)
                .foregroundColor(Color.white)
                .disableAutocorrection(true)
            
        }
        .font(.headline)
        .padding(10)
        .background(
        RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.gray.opacity(0.3))
        )
        .padding()
    }
}
