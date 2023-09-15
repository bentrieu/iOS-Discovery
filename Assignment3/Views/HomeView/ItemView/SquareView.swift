//
//  BigSquareView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct SquareView: View {
    var imageUrl : String
    var size : CGFloat
    var body: some View {
        
        VStack(spacing: 10){
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                
            }
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()

            
        }
        
    }
}

struct SquareView_Provider: PreviewProvider {
    static var previews: some View {
        SquareView(imageUrl: "https://wallpapercave.com/wp/wp10044095.jpg", size: 175)
    }
}

