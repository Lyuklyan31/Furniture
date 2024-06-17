import SwiftUI

struct PhoneAuthView: View {
    @ObservedObject var viewModel: AuthenticationPhoneViewModel
    @FocusState var isEnabled: Bool
    var contentType: UITextContentType = .telephoneNumber
    
    var body: some View {
        HStack {
            Image(systemName: "phone")
                .foregroundColor(.primary)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black.opacity(0.2))
                        .padding()
                }
            
            TextField("Phone", text: $viewModel.phoneNumber)
                .focused($isEnabled)
                .textContentType(contentType)
                .keyboardType(.numberPad)
            Spacer()
            
            Button {
                if viewModel.phoneNumber.count == 13 {
                    viewModel.startTimer()
                    Task {
                        do {
                            try await viewModel.sendVerificationCode(phoneNumber: viewModel.phoneNumber)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            } label: {
                HStack {
                    if viewModel.timerIsRunning == true {
                        Text("\(viewModel.remainingTime)")
                            .foregroundColor(.primary)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    } else {
                        Text("Get Code")
                            .fontWeight(.semibold)
                            .contentTransition(.identity)
                    }
                }
            }
            .disabled(viewModel.timerIsRunning)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.primary.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 10)
                .trim(from: 0, to: isEnabled ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(.primary)
                .scaleEffect(x: -1, y: 1)
                .animation(.easeInOut(duration: 0.7), value: isEnabled)
        }
        .padding()
    }
}
