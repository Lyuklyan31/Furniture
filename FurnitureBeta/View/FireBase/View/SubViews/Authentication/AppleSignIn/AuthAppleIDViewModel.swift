//
//  AuthAppleIDViewModel.swift
//  FurnitureBeta
//
//  Created by admin on 06.06.2024.
//

import SwiftUI
import CryptoKit
import AuthenticationServices

@MainActor
final class AuthAppleIDViewModel:  ObservableObject {
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthennticationManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        
        if try await UserManager.shared.userExists(userId: user.userId) {
            try await UserManager.shared.updateUser(user: user)
        } else {
            try await UserManager.shared.createNewUser(user: user)
        }
    }
}
