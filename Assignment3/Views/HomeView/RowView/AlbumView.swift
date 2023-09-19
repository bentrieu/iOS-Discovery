//
//  RowForSquareView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct AlbumView : View {
    @State var albums : [Album] = []
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Album")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(albums, id: \.albumId) { item in
                        VStack(alignment: .leading){
                            SquareView(imageUrl: item.imageUrl!, size: 160)
                            TextForAlbumView(title: item.title!, type: item.type!, name: item.artistName!, size: 160)
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .padding(.vertical)
        .onAppear{
            Task{
                 AlbumManager.shared.fetchPopularAlbumList { result, error in
                    self.albums = result!
                }
            }
        }
    }
}

struct RowForSquareView_Previews: PreviewProvider {
    static var previews: some View {
      Text("")
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
                .tracking(-1)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Medium", size: 16))
            HStack(spacing: 5){
                Text(type)
                
                Text(".")
                    .font(.system(size: 45))
                    .offset(y:-15)
                Text(name)
                    .tracking(-1)
                Spacer()
            }
            .offset(y:-10)
            .font(Font.custom("Gotham-Medium", size: 16))
            .foregroundColor(Color("black").opacity(0.6))
            .frame(width: size)
        }
    }
}








