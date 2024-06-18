//
//  MeViewModel.swift
//  FurnitureBeta
//
//  Created by admin on 06.06.2024.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class MeViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var phoneNumber: String = ""
    @Published var verificationID: String = ""
    @Published var verificationCODE: String = ""
    
    @Published var isLinkedWithGoogle: Bool = false
    @Published var isLinkedWithApple: Bool = false
    @Published var isLingedWithEmail: Bool = false
    @Published var isLingedWithPhone: Bool = false
    
    @Published private(set) var user: DBUser? = nil
    
    
    // MARK: - Methods
    
    func saveProfileImage(item: PhotosPickerItem) {
        guard let user = user else { return }

        Task {
            do {
                guard let data = try await item.loadTransferable(type: Data.self) else { return }
                let (path, name) = try await StorageManager.shared.saveImage(data: data, userId: user.userId)
                print("Success")
                print(path)
                print(name)
                deleteProfileImage()
                let url = try await StorageManager.shared.getUrlForImage(path: path)
                try await UserManager.shared.updateProfileImagePath(userId: user.userId, path: path, url: url.absoluteString)
                try await loadCurrentUser()
            } catch {
                print("Error saving profile image:", error.localizedDescription)
            }
        }
    }
    
    func deleteProfileImage() {
        guard let user = user, let path = user.profileImagePath else { return }

        Task {
            do {
                try await StorageManager.shared.deleteImage(path: path)
                try await UserManager.shared.updateProfileImagePath(userId: user.userId, path: nil, url: nil)
                try await loadCurrentUser()
            } catch {
                print("Error deleting profile image:", error.localizedDescription)
            }
        }
    }
    func changeEmailtName(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserEmail(userId: user.userId, email: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    
    func changePhoneNumber(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserProfilePhoneNumber(userId: user.userId, phoneNumber: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func changeFirstName(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserFirstName(userId: user.userId, firstName: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func changeLastName(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserLastName(userId: user.userId, lastName: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func changeAddress(text: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.updateUserAddress(userId: user.userId, address: text)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func checkProviders() async {
        do {
            let providers = try AuthennticationManager.shared.getProviders()
            isLinkedWithGoogle = providers.contains(.google)
            isLinkedWithApple = providers.contains(.apple)
            isLingedWithEmail = providers.contains(.email)
            isLingedWithPhone = providers.contains(.phoneNumber)
        } catch {
            print(error)
        }
    }
 
    func loadCurrentUser() async throws {
        let authDataResult = try AuthennticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func loadAuthProviders() {
        if let providers = try? AuthennticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthennticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() async throws {
        try AuthennticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthennticationManager.shared.delete()
    }
    
    //MARK: - RESET PASSWORD
    func resetPassword() async throws {
        let authUser = try AuthennticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
         
        try await AuthennticationManager.shared.resetPassword(email: email)
    }
    //MARK: - UPDATE
    func updateEmail() async throws {
        let email = "Penis@gmail.com"
        try await AuthennticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "$Penis321"
        try await AuthennticationManager.shared.updatePassword(password: password)
    }
    
    //MARK: - LINKS
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthennticationManager.shared.linkGoogle(tokens: tokens)
    }
    
    func linkAppleAccount() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.authUser = try await AuthennticationManager.shared.linkApple(tokens: tokens)
    }
    
    func linkEmailAccount() async throws {
        let email = email
        let password = password
        changeEmailtName(text: email)
        self.authUser = try await AuthennticationManager.shared.linkEmail(email: email, password: password)
    }
    
    func linkPhoneAccount() async throws {
        let verificationID = verificationID
        let verificationCODE = verificationCODE
        changePhoneNumber(text: phoneNumber)
        self.authUser = try await AuthennticationManager.shared.linkPhone(verificationID: verificationID, verificationCODE: verificationCODE)
    }
}
