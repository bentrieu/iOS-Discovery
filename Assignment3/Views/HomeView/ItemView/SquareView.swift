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
            AsyncImage(url: URL(string: imageUrl))
                .frame(width: size, height: size)
                .scaledToFit()
                .clipped()

           
            
        }
        
    }
}

struct SquareView_Provider: PreviewProvider {
    static var previews: some View {
        SquareView(imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", size: 175)
    }
}

struct TextForAlbumView: View {
    var title : String
    var type : String
    var name : String
    var size : CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: -5){
            Text(title)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Medium", size: 16))
            HStack(spacing: 5){
                Text(type)
                
                Text(".")
                    .font(.system(size: 45))
                    .offset(y:-15)
                Text(name)
                Spacer()
            }
            .offset(y:-10)
            .font(Font.custom("Gotham-Medium", size: 16))
            .foregroundColor(Color("black").opacity(0.6))
            .frame(width: size)
        }
    }
}
