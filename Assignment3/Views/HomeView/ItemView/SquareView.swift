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
        SquareView(imageUrl: "https://i.scdn.co/image/ab67616d0000b273b315e8bb7ef5e57e9a25bb0f", size: 175)
    }
}

