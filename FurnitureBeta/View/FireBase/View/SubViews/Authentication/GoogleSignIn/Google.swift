//
//  Google.swift
//  FurnitureBeta
//
//  Created by admin on 02.06.2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct Google: View {
    @StateObject private var viewModel = AuthenticationGoogleViewModel()
    @Binding var currentShowingView: String
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                    } catch {
                        print(error)
                    }
                }
                
            }label: {
                HStack {
                    Image(.google)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                      
                     
                    Text("Sign in with Google")
                        .foregroundColor(currentShowingView == "login" ? .black : .white)
                        .offset(x: -10)
                }
                .font(.headline)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(currentShowingView == "login" ? .black : .white, lineWidth: 2)
                    }
            }
            .padding(.horizontal, 40)
        }
        
    }
}


