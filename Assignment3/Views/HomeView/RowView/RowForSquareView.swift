//
//  RowForSquareView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct RowForSquareView <Content:View>: View {
    var title: String
    var itemList : [SquareStruct]
    var size : CGFloat
   
    let content : Content
    
    init(title: String, itemList: [SquareStruct], size : CGFloat, @ViewBuilder content: () -> Content) {
        self.title = title
        self.itemList = itemList
        self.size = size
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(itemList, id: \.id) { item in
                        VStack(alignment: .leading){
                            SquareView(imageUrl: item.imageUrl, size: size)
                            self.content
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
        RowForSquareView(title: "Popular Album", itemList: bigSquareDataArray, size: 175){
            
        }
    }
}


struct SquareStruct: Identifiable {
    let id = UUID()
    let imageUrl: String
    let title: String
    let type: String
    let name: String
}

let bigSquareDataArray: [SquareStruct] = [
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    ),
    SquareStruct(
        imageUrl: "https://yt3.googleusercontent.com/xfFkNTU0Kg_u1Im9W11kI1AkWnpoz91gnYjk1pZZHN5gN_ul3OnBHS7ZrWS35SitlezR5QI9gQ=s176-c-k-c0x00ffffff-no-rj",
        title: "MIN",
        type: "Single",
        name: "Min"
    )
]
