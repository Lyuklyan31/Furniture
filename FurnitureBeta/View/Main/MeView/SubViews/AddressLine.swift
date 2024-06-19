//
//  AddressLine.swift
//  FurnitureBeta
//
//  Created by admin on 18.06.2024.
//

import SwiftUI

struct AddressLine: View {
    var viewModel: MeViewModel
    
    @State var address: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location")
                
                Text("City")
                
                Spacer()
            }
            .offset(y: 3)
            .padding(.horizontal, 30)
            HStack {
                Image(systemName: "location")
                
                TextField("City", text: $address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    viewModel.changeAddress(text: address)
                } label: {
                    Text("Change")
                        .bold()
                }
                .disabled(address.isEmpty || address == viewModel.user?.address)

            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            }
            .padding(.horizontal)
        }
    }
}

