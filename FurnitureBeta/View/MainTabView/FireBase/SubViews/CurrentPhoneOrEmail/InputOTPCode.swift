import SwiftUI

struct InputOTPCode: View {
    
    @FocusState var isEnabled: Bool
    @Binding var currentViewShowing: String
    
    @ObservedObject var viewModel: AuthViewModel
    
    var contentType: UITextContentType = .telephoneNumber
    var body: some View {
        
            
            HStack {
                Image(systemName: "ellipsis.bubble")
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.2))
                            .padding()
                    }
                 
                TextField("OTP CODE", text: $viewModel.otpCode)
                    .focused($isEnabled)
                    .textContentType(contentType)
                    .keyboardType(.numberPad)
                Spacer()
                
                Text("\(viewModel.remainingTime)")
                               .font(.system(size: 20))
                               .padding(.horizontal)
            }
            .padding(.horizontal)
        ZStack(alignment: .leading) {
           Rectangle()
                    .fill(currentViewShowing == "login" ? .black.opacity(0.2) : .white.opacity(0.2))
         Rectangle()
                    .fill(currentViewShowing == "login" ? .black : .white)
                    .frame(width: isEnabled ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.7), value: isEnabled)
            }
            .frame(height: 2)
            .padding(.horizontal)

        
    }
}
