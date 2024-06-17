//
//  Anonymous.swift
//  FurnitureBeta
//
//  Created by admin on 02.06.2024.
//

import SwiftUI

struct Anonymous: View {
    
    @ObservedObject var viewModel = AuthAnonymouseViewModel()
    var body: some View {
        Button {
            Task {
                do {
                    try await  viewModel.signInAnonymous()
                } catch {
                    print(error)
                }
            }
           
        } label: {
            HStack {
                Text("Anonymous")
                    .font(.headline)
                    .foregroundColor(.black)
                   
                Image(systemName: "person.fill")
                    .font(.title3)
                    .foregroundColor(.black)
                  
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
        
            .overlay {
            RoundedRectangle(cornerRadius: 11)
                .stroke(Color.black, lineWidth: 2)
            }
        }
        .padding(.horizontal, 40)
        
    }
}

