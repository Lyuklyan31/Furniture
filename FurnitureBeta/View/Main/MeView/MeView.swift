
import SwiftUI

struct MeView: View {
    @StateObject private var viewModel = MeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    MePersonView(viewModel: viewModel)
                        .padding()
                   
                       
                    if let user = viewModel.user {
                        FirstNameLastName(viewModel: viewModel, firstName: user.firstName ?? "", lastName: user.lastName ?? "")
                          
                        if ((user.email?.isEmpty) != nil) {
                            EmailLine(viewModel: viewModel, email: user.email ?? "")
                        }
                        
                        if ((user.phoneNumber?.isEmpty) != nil) {
                            PhoneLine(viewModel: viewModel, phoneNumber: user.phoneNumber ?? "")
                        }
                    }
                       
                    
                    ButtonForNavigation(systemImage: "heart.fill", title: "Favorite", destination: FavoriteView(), color: .red)
                        .padding(.top, 40)
                    ButtonForNavigation(systemImage: "phone.fill", title: "Our contacts", destination: OurContacts(), color: .black)
                    
                    ButtonForNavigation(systemImage: "cart", title: "Order History", destination: FavoriteView(), color: .black)
                    
                    ButtonForNavigation(systemImage: "house", title: "About Us", destination: AboutUs(), color: .black)
                    Spacer()
                    
                    MeViewSingUp(viewModel: viewModel)
                    
                        .padding(40)
                    ButtonDelete()
                    
                    
                    
                }
            }
            .navigationTitle("Profile")
            .task {
                viewModel.loadAuthProviders()
                viewModel.loadAuthUser()
                await viewModel.checkProviders()
                try? await viewModel.loadCurrentUser()
            }
            .toolbar {
                Button {
                    Task {
                        do {
                            try AuthennticationManager.shared.signOut()
                        } catch {
                            print(error)
                        }
                    }
                 
                } label: {
                    HStack {
                        Text("Sign Out")
                            .bold()
                    }
                    .font(.title3)
                }
            }
        }
    }
}

