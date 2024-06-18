
import SwiftUI

struct PhoneLine: View {
    var viewModel: MeViewModel
    
    @State var phoneNumber: String
    
    var body: some View {
        VStack {
            if phoneNumber.isEmpty {
                HStack {
                    Image(systemName: "phone.fill")
                    
                    Text("Phone")
                    
                    Spacer()
                }
                .offset(y: 3)
                .padding(.horizontal, 30)
            }
            HStack {
                Image(systemName: "phone")
                
                Text(phoneNumber)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .frame(maxWidth: .infinity)
//                Button {
//
//                } label: {
//                    Text("Change")
//                        .bold()
//                }
//                
//                 .disabled(phoneNumber.isEmpty || phoneNumber == viewModel.user?.phoneNumber)
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


