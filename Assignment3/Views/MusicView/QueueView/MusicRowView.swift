//
//  TrackRowView.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct MusicRowView: View {
    let imgDimens: CGFloat
    let titleSize: CGFloat
    let subTitleSize: CGFloat
    var music :  Music
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/25){
            SquareView(imageUrl: music.imageUrl!, size: imgDimens)
            VStack{
                Text(music.musicName!)
                    .font(.custom("Gotham-Medium", size: titleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(music.artistName!)
                    .font(.custom("Gotham-Book", size: subTitleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear{
            print(music.imageUrl!)
        }
        .frame(width: .infinity)
    }
}

//struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicRowView(imgName: "testImg", imgDimens: 60, title: "Song Name", titleSize: 21, subTitle: "Artists", subTitleSize: 17)
//    }
//}
