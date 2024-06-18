//
//  OrderSheet.swift
//  FurnitureBeta
//
//  Created by admin on 05.06.2024.
//

import SwiftUI

struct OrderSheet: View {
    @StateObject var meViewModel = MeViewModel()
    @FetchRequest(sortDescriptors: []) var products: FetchedResults<ProductEntity>
    
    var totalPrice: Double {
           products.reduce(0) { $0 + $1.price * Double($1.amount) }
       }
    var body: some View {
        
        VStack {
            if let user = meViewModel.user {
                if user.isAnonymous == true {
                    Text("You must Sign Up")
                } else {
                    if let user = meViewModel.user {
                        HStack {
                            Text(user.firstName ?? "Please add your first name.")
                            Text(user.lastName ?? "Please add your last name.")
                        }
                        .padding()
                    }
                    if let user = meViewModel.user {
                        HStack {
                            Text("Your Email")
                                .padding(.horizontal)
                            Spacer()
                            Text(user.email ?? "Please Linked your Google or Gmail account.")
                                .padding(.horizontal)
                        }
                    }
                    if let user = meViewModel.user {
                        HStack {
                            Text("Your Phone")
                                .padding(.horizontal)
                            Spacer()
                            Text(user.phoneNumber ?? "Please Linked your phone number account.")
                                .padding(.horizontal)
                            
                        }
                    }
                    if let user = meViewModel.user {
                        HStack {
                            AddressLine(viewModel: meViewModel, address: meViewModel.user?.address ?? "Please enter your address")
                            Spacer()
                        }
                    }
                }
                
                VStack {
                    Text("Total price ")
                        .bold()
                    Text("\(String(format: "%.2f", totalPrice))$")
                        
                }
                
                    List(products) { item in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(item.name ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("$\(String(format: "%.2f", item.price * Double(item.amount)))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            HStack {
                                Text(item.selectedColor ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("x\(item.amount)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            Divider()
                        }
                        .padding(.vertical, 5)
                    }
               
                    
                    
                    Spacer()
                
                Button {
                    
                } label: {
                    Text("Order")
                        .foregroundColor(.primary)
                        .padding()
                        .padding(.horizontal, 40)
                        .clipShape(.capsule)
                        .overlay {
                            Capsule()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.primary)
                        }
                        .background {
                            Capsule()
                            .foregroundColor(.gray)
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
