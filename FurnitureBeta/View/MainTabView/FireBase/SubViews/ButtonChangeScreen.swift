//
//  ButtonChangeScreen.swift
//  FurnitureBeta
//
//  Created by admin on 31.05.2024.
//

import SwiftUI

struct ButtonChangeScreen: View {
    @Binding var currentViewShowing: String
    var body: some View {
        Button {
            withAnimation {
                if currentViewShowing == "login" {
                    currentViewShowing = "signup"
                } else {
                    currentViewShowing = "login"
                }
            }
        } label: {
            if(currentViewShowing == "login") {
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.7))
            } else {
                Text("Already have an account?")
                    .padding()
                    .foregroundColor(.gray)
            }
                
        }
        
        Spacer()
        Spacer()
    }
}

