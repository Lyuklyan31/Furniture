

import SwiftUI

struct ButtonDelete: View {
    var body: some View {
      
        Button(role: .destructive) {
            Task {
                do {
                    try await AuthennticationManager.shared.delete()
                } catch {
                    print(error)
                }
            }
        } label: {
            HStack {
                Text("Delete Account")
                   
                    .bold()
                    
                Image(systemName: "trash")
                    
                    
            }
            .foregroundColor(.white)
            .padding()
            .background{
                Capsule()
                    .foregroundColor(.red)
            }
            .overlay {
                Capsule()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    ButtonDelete()
}
