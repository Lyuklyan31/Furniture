//
//  AuthenticationGoogleViewModel.swift
//  FurnitureBeta
//
//  Created by admin on 06.06.2024.
//

import SwiftUI

@MainActor
final class AuthenticationGoogleViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthennticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
      
        if try await UserManager.shared.userExists(userId: user.userId) {
            try await UserManager.shared.updateUser(user: user)
        } else {
            try await UserManager.shared.createNewUser(user: user)
        }
    }
}
