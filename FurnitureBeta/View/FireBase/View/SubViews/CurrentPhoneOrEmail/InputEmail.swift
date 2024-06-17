//
//  InputEmilView.swift
//  FurnitureBeta
//
//  Created by admin on 28.05.2024.
//

import SwiftUI

struct InputEmail: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    @FocusState var isEnabled: Bool
    @Binding var currentViewShowing: String
    var body: some View {
        
        HStack {
            Image(systemName: "mail")
            TextField("Email", text: $viewModel.email)
                .focused($isEnabled)
            Spacer()
            
            if(viewModel.email.count != 0) {
                Image(systemName: viewModel.email.isValidEmail() ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.email.isValidEmail() ? .green : .red)
            }
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(currentViewShowing == "login" ? .black.opacity(0.2) : .white.opacity(0.2))

            RoundedRectangle(cornerRadius: 10)
                .trim(from: 0, to: isEnabled ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(currentViewShowing == "login" ? .black : .white)
                .scaleEffect(x: -1, y: 1)
                .animation(.easeInOut(duration: 0.7), value: isEnabled)
        }
        .padding()

    }
}

