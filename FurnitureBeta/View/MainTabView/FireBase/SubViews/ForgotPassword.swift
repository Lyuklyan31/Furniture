//
//  ForgotPassword.swift
//  FurnitureBeta
//
//  Created by admin on 31.05.2024.
//

import SwiftUI

struct ForgotPassword: View {
    @ObservedObject var viewModel: AuthViewModel
    @FocusState var isEnabled: Bool
    @Binding var currentPhoneOrEmail: String
    @Binding var currentViewShowing: String
    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.title)
                .bold()
            
            HStack {
                Image(systemName: "mail")
                TextField("Please enter your Email", text: $viewModel.forgotPassword)
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
            
            Button {
                Task {
                    do {
                      
                            try await viewModel.resetPasswordEmail()
                       
                        
                    } catch {
                        print(error)
                    }
                }
                print("PASSWORD RESET!")
            } label: {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                
                    .frame(maxWidth: .infinity)
                    .padding()
                
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                    )
                    .padding(.horizontal)
                
            }
            
        }
    }
    
    
    
}
