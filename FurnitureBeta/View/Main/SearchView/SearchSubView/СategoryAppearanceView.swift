import SwiftUI
import Kingfisher

struct СategoryAppearanceView: View {
    var category: Category?
    
    var body: some View {
        VStack {
            if let photo = category?.photo {
                KFImage(URL(string: photo))
                    .resizable()
                    .frame(height: 189)
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 8)
            }
            
            HStack {
                Text(category?.name ?? "N/A")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
            }
        }
    }
}
