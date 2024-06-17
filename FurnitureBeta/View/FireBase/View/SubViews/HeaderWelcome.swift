//
//  HeaderWelcome.swift
//  FurnitureBeta
//
//  Created by admin on 30.05.2024.
//

import SwiftUI

struct HeaderWelcome: View {
    @Binding var currentShowingView: String
    var body: some View {
        HStack {
            
            //MARK: WELCOME
            Text(currentShowingView == "login" ? "Welcome Back!" : "Create an Account!")
                .font(.largeTitle)
                .bold()
            
            Spacer()
        }
        .padding()
        .padding(.top)
        
        Spacer()
    }
}

