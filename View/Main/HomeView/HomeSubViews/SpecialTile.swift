//
//  Tile2.swift
//  FurnitureBeta
//
//  Created by admin on 22.05.2024.
//

import SwiftUI
import Kingfisher

struct Tile2: View {
    let special: Special
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let imageSize = adaptiveSize(for: screenWidth)
        
            HStack(spacing: 20) {
                KFImage(URL(string: special.photo1))
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(11)
                    .shadow(radius: 7)
                
                KFImage(URL(string: special.photo2))
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .cornerRadius(11)
                    .shadow(radius: 7)
            }
    }
    func adaptiveSize(for screenWidth: CGFloat) -> CGFloat {
        if screenWidth > 500 {
            return 166
        } else {
            return screenWidth * 0.45
        }
    }
}
