import SwiftUI

struct AmountFurnitureView: View {
    @Binding var amount: Int
    
    var body: some View {
        HStack {
            Button(action: decreaseAmount) {
                Circle()
                    .frame(maxWidth: 45, maxHeight: 45)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay {
                        Image(systemName: "minus")
                            .bold()
                            .foregroundColor(.black)
                    }
            }
            .disabled(amount <= 1)
            
            Text("\(amount)")
                .font(.largeTitle)
                .frame(maxWidth: 43)
                .padding()
            
            Button(action: increaseAmount) {
                Circle()
                    .frame(maxWidth: 45, maxHeight: 45)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .overlay {
                        Image(systemName: "plus")
                            .bold()
                            .foregroundColor(.black)
                    }
            }
            .disabled(amount >= 99)
        }
    }
    
    func increaseAmount() {
        amount += 1
    }
    
    func decreaseAmount() {
        if amount > 0 {
            amount -= 1
        }
    }
}
