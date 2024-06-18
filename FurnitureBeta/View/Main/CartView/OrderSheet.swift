//
//  OrderSheet.swift
//  FurnitureBeta
//
//  Created by admin on 05.06.2024.
//

import SwiftUI

struct OrderSheet: View {
    @StateObject var meViewModel = MeViewModel()
    
    
    var body: some View {
        VStack {
            if let user = meViewModel.user {
                if user.isAnonymous == true {
                    Text("You must Sign Up")
                } else {
                    if let user = meViewModel.user {
                        FirstNameLastName(viewModel: meViewModel, firstName: user.firstName ?? "", lastName: user.lastName ?? "")
                    }
                    if let user = meViewModel.user {
                        EmailLine(viewModel: meViewModel, email: user.email ?? "")
                    }
                    if let user = meViewModel.user {
                        PhoneLine(viewModel: meViewModel, phoneNumber: user.phoneNumber ?? "")
                    }
                }
            }
        }
            .task {
                meViewModel.loadAuthProviders()
                meViewModel.loadAuthUser()
                await meViewModel.checkProviders()
                try? await meViewModel.loadCurrentUser()
            }
    }
    
}

#Preview {
    OrderSheet()
}
