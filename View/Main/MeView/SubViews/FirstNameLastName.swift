//
//  PersonalData.swift
//  FurnitureBeta
//
//  Created by admin on 05.06.2024.
//

import SwiftUI

struct FirstNameLastName: View {
@ObservedObject var viewModel: MeViewModel
   @State var firstName: String
   @State var lastName: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.fill")
                   
                Text("First name")
                   
                Spacer()
            }
            .offset(y: 3)
            .padding(.horizontal, 30)
            HStack {
                Image(systemName: "person")
                
                TextField("First name", text: $firstName)
                Button {
                    viewModel.changeFirstName(text: firstName)
                } label: {
                    Text("Change")
                        .bold()
                }
                .disabled(firstName.isEmpty || firstName == viewModel.user?.firstName)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            }
            .padding(.horizontal)
            
            
            HStack {
                Image(systemName: "person.fill")
                    
                Text("Last name")
                Spacer()
            }
            .offset(y: 3)
            .padding(.horizontal, 30)
            HStack {
                Image(systemName: "person")
                   
                TextField("Last name", text: $lastName)
                Button {
                    viewModel.changeLastName(text: lastName)
                } label: {
                    Text("Change")
                        .bold()
                }
                .disabled(lastName.isEmpty || lastName == viewModel.user?.lastName)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            }
            .padding(.horizontal)
        }
        
    }
}
