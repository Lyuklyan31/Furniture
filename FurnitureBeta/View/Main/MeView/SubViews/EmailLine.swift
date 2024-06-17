//
//  EmailLine.swift
//  FurnitureBeta
//
//  Created by admin on 12.06.2024.
//

import SwiftUI

struct EmailLine: View {
    var viewModel: MeViewModel
    
    @State var email: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mail.fill")
                
                Text("Email")
                
                Spacer()
            }
            .offset(y: 3)
            .padding(.horizontal, 30)
            HStack {
                Image(systemName: "mail")
                
                TextField("First name", text: $email)
//                Button {
//                    
//                   
//                    
//                } label: {
//                    Text("Change")
//                        .bold()
//                }
//                 .disabled(email.isEmpty || email == viewModel.user?.email)
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

