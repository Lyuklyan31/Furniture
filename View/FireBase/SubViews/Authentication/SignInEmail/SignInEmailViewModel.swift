//
//  EmailAuth.swift
//  FurnitureBeta
//
//  Created by admin on 04.06.2024.
//

import SwiftUI

final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    
    @Published var showForgotPassword = false
    @Published var showWarning = false
    @Published var showAlert = false
    
    @Published var warningText = ""
    @Published var title = ""
    @Published var message = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        let authDataResult = try await AuthennticationManager.shared.createUser(email: email, password: password)
        
        let user = DBUser(auth: authDataResult)
        if try await UserManager.shared.userExists(userId: user.userId) {
            try await UserManager.shared.updateUser(user: user)
        } else {
            try await UserManager.shared.createNewUser(user: user)
        }
        
        
    }
    
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        let authDataResult = try await AuthennticationManager.shared.signInUser(email: email, password: password)
       
    }
}
