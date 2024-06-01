//
//  InputPhoneView.swift
//  FurnitureBeta
//
//  Created by admin on 29.05.2024.
//

import SwiftUI

struct InputPhone: View {
    
    @ObservedObject var viewModel: AuthViewModel
    @FocusState var isEnabled: Bool
    
    @Binding var currentViewShowing: String
    var contentType: UITextContentType = .telephoneNumber
    var body: some View {
        
            
            HStack {
                Image(systemName: "phone")
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black.opacity(0.2))
                            .padding()
                    }
                 
                TextField("Phone", text: $viewModel.phone)
                    .focused($isEnabled)
                    .textContentType(contentType)
                    .keyboardType(.numberPad)
                Spacer()
            
                Button {
                    if(viewModel.phone.count == 13) {
                        viewModel.startTimer()
                        viewModel.getOTPCode()
                    }
                } label: {
                    HStack {
                        Text("Get Code")
                            .foregroundColor({
                                       if currentViewShowing == "login" {
                                           return viewModel.timerIsRunning ? .gray : .black
                                       } else {
                                           return viewModel.timerIsRunning ? .gray : .white
                                       }
                                   }())
                            .fontWeight(.semibold)
                            .contentTransition(.identity)
                    }
                }
                .disabled(viewModel.timerIsRunning)
                
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

