//
//  ListRowView.swift
//  Assignment3
//
//  Created by DuyNguyen on 20/09/2023.
//

import SwiftUI

struct PlaylistRowView: View {
    let imgDimens: CGFloat
    let titleSize: CGFloat
    let subTitleSize: CGFloat
    var playlist :  DBPlaylist
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/25){

            SquareView(imageUrl: playlist.photoUrl!, size: imgDimens)
            VStack(spacing: 5){
                Text(playlist.name!)
                    .font(.custom("Gotham-Medium", size: titleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(playlist.musics!.count) tracks")
                    .font(.custom("Gotham-Book", size: subTitleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear{
            print(playlist.photoUrl!)
        }
        .frame(width: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

//struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistRowView(imgDimens: <#CGFloat#>, titleSize: <#CGFloat#>, subTitleSize: <#CGFloat#>, music: <#Music#>)
//    }
//}
