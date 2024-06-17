import SwiftUI

struct BackgroundImagesView: View {
    var body: some View {
        ZStack {
            Image("backraund")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .overlay(
                    Color.black.opacity(0.3)
                        .mask(
                            Image("backraund")
                                .resizable()
                                .scaledToFit()
                        )
                )
                .blur(radius: 2.0)
                .offset(x: -80, y: 60)
            
            Image("miniSofa")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 150)
                .overlay(
                    Color.black.opacity(0.3)
                        .mask(
                            Image("miniSofa")
                                .resizable()
                                .scaledToFit()
                        )
                )
                .blur(radius: 2.0)
                .offset(x: 90, y: -110)
        }
    }
}
