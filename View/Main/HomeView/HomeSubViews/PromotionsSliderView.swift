import SwiftUI
import Kingfisher

struct PromotionsSliderView: View {
    var promotions: [Promotions]
    @State private var index = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            
            let screenWidth = UIScreen.main.bounds.width
            let imageSize = adaptiveSize(for: screenWidth)
            
            TabView(selection: $index) {
                ForEach(promotions.indices, id: \.self) { index in
                    KFImage(URL(string: promotions[index].photo))
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSize, height: 550)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 550)
            .shadow(radius: 7)
            
        }
        .ignoresSafeArea()
        .onReceive(timer, perform: { _ in
            withAnimation {
                index = index < promotions.count - 1 ? index + 1 : 0
            }
        })
    }
    
    func adaptiveSize(for screenWidth: CGFloat) -> CGFloat {
        if screenWidth > 500 {
            return 166
        } else {
            return screenWidth * 1
        }
    }
}
