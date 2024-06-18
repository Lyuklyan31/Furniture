//
//  DBUser.swift
//  FurnitureBeta
//
//  Created by admin on 11.06.2024.
//

import Foundation

struct DBUser: Codable {
    let userId: String
    let isAnonymous: Bool?
    let email: String?
    let dataCreated: Date?
    let firstName: String?
    let lastName: String?
    let profileImagePath: String?
    let profileImagePathURL: String?
    let phoneNumber: String?
    let address: String?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.dataCreated = Date()
        self.firstName = nil
        self.lastName = nil
        self.profileImagePath = nil
        self.profileImagePathURL = nil
        self.phoneNumber = nil
        self.address = nil
    }
    
    init(
     userId: String,
     isAnonymous: Bool? = nil,
     email: String? = nil,
     dataCreated: Date? = nil,
     firstName: String? = nil,
     lastName: String? = nil,
     profileImagePath: String? = nil,
     profileImagePathURL: String? = nil,
     phoneNumber: String? = nil,
     address: String? = nil
    ) {
        self.userId = userId
        self.isAnonymous = isAnonymous
        self.email = email
        self.dataCreated = dataCreated
        self.firstName = firstName
        self.lastName = lastName
        self.profileImagePath = profileImagePath
        self.profileImagePathURL = profileImagePathURL
        self.phoneNumber = phoneNumber
        self.address = address
    }
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case dataCreated = "data_created"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImagePath = "profile_image_path"
        case profileImagePathURL = "profile_image_path_url"
        case phoneNumber = "phone_number"
        case address = "address"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
        self.profileImagePathURL = try container.decodeIfPresent(String.self, forKey: .profileImagePathURL)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.isAnonymous, forKey: .isAnonymous)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.dataCreated, forKey: .dataCreated)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
        try container.encodeIfPresent(self.profileImagePathURL, forKey: .profileImagePathURL)
        try container.encodeIfPresent(self.phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(self.address, forKey: .address)
    }
}
