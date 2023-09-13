//
//  SmallCirlceView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct SmallCirlceView: View {
    var imageUrl : String
    var name : String
    var body: some View {
        VStack(spacing: -15){
            AsyncImage(url: URL(string: imageUrl))
                .frame(width: 130)
                .clipShape(Circle())
            Text(name)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Book", size: 16))
        }
    }
}

struct SmallCirlceView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCirlceView(imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min")
    }
}


