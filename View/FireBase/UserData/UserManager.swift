//
//  UserManager.swift
//  FurnitureBeta
//
//  Created by admin on 10.06.2024.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func userExists(userId: String) async throws -> Bool {
        let document = try await userDocument(userId: userId).getDocument()
        return document.exists
    }
    
    func updateUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }
    
    func getUser(userId: String) async throws -> DBUser  {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func updateUserFirstName(userId: String, firstName: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.firstName.rawValue : firstName
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserLastName(userId: String, lastName: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.lastName.rawValue : lastName
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserEmail(userId: String, email: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.email.rawValue : email
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserProfilePhoneNumber(userId: String, phoneNumber: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.phoneNumber.rawValue : phoneNumber
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    func updateProfileImagePath(userId: String, path: String?, url: String?) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.profileImagePath.rawValue : path,
            DBUser.CodingKeys.profileImagePathURL.rawValue : url,
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    
}
