//
//  ButtonForNavigation.swift
//  FurnitureBeta
//
//  Created by admin on 09.06.2024.
//

import SwiftUI

struct ButtonForNavigation<Destination: View>: View {
    var systemImage: String
    var title: String
    var destination: Destination
    var color: Color
    
    var body: some View {
        NavigationLink {
           destination
        } label: {
            HStack {
                Text(title)
                    .bold()
                    .foregroundColor(.primary)
                Image(systemName: systemImage)
                    .foregroundColor(title == "Favorite" ? .red : .primary)
//                    .overlay {
//                        if systemImage == "cart" {
//                            ZStack {
//                                Circle()
//                                    .frame(maxWidth: 20, maxHeight: 20)
//                                    .foregroundColor(.red)
//                                
//                                Text("0")
//                                    .font(.system(size: 10))
//                                    .foregroundColor(.white)
//                            }
//                            .offset(x: 3)
//                            
//                        }
//                    }
            }
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
    }
}

