//
//  RowForSquareView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct AlbumView : View {
    var albums : [Album]
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Album")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(albums, id: \.id) { item in
                        VStack(alignment: .leading){
                            SquareView(imageUrl: item.imageUrl, size: 175)
                            TextForAlbumView(title: item.title, type: "Album", name: item.name, size: 175)
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .padding(.vertical)
    }
}

struct RowForSquareView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(albums: albums)
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






struct Album: Identifiable {
    let id = UUID()
    let imageUrl: String
    let title: String
    let type: String
    let name: String
}

let albums: [Album] = [
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    Album(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    )
]
