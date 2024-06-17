//
//  AuthAnonymouseViewModel.swift
//  FurnitureBeta
//
//  Created by admin on 07.06.2024.
//

import Foundation
import SwiftUI

class AuthAnonymouseViewModel: ObservableObject {
    
    func signInAnonymous() async throws {
       let authDataResult = try await AuthennticationManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
