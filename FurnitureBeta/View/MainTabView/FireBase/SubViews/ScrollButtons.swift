//
//  ScrolBattons.swift
//  FurnitureBeta
//
//  Created by admin on 28.05.2024.
//

import SwiftUI

struct ScrollButtons: View {
   
    @Binding var currentPhoneOrEmail: String 
    @Binding var currentViewShowing: String
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        
            HStack(spacing: 80) {
                Spacer()
                
                Button {
                    withAnimation {
                        currentPhoneOrEmail = "Phone"
                    }
                } label: {
                    Text("Phone")
                        .font(.title)
                        .bold()
                        .foregroundColor({
                                   if currentViewShowing == "login" {
                                       return currentPhoneOrEmail == "Phone" ? .black : .gray
                                   } else {
                                       return currentPhoneOrEmail == "Phone" ? .white : .gray
                                   }
                               }())
                }
                
                
                Button {
                    withAnimation {
                        currentPhoneOrEmail = "Email"
                    }
                } label: {
                    Text("Email")
                        .font(.title)
                        .bold()
                        .foregroundColor({
                                   if currentViewShowing == "login" {
                                       return currentPhoneOrEmail == "Email" ? .black : .gray
                                   } else {
                                       return currentPhoneOrEmail == "Email" ? .white : .gray
                                   }
                               }())
                }
                Spacer()
            }
            
        }
        .offset(y: 10)
    }
}

