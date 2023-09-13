//
//  RowView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct RowView: View {
    var title: String
    var itemList : [CircleViewStruct]
   
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack{
                    ForEach(itemList, id: \.id) { item in
                        SmallCirlceView(imageUrl: item.imageURL, name: item.name)
                        
                    }
                }
                .offset(x:10)
            }
            
        }
        
    }
}
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(title: "Popular Artists", itemList: items)
    }
}

struct CircleViewStruct: Identifiable {
    let id = UUID()
    let imageURL: String
    let name: String
}

let items: [CircleViewStruct] = [
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min"),
    CircleViewStruct(imageURL: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj", name: "Min")
]
