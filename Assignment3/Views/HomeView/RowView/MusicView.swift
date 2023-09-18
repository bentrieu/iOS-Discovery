//
//  SwiftUIView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct MusicView: View {
    var musics : [Music]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Played")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(musics, id: \.musicId) { item in
                        NavigationLink {
                            PlayMusicView()
                        }label: {
                            VStack(alignment: .leading){
                                SquareView(imageUrl: item.imageURL, size: 125)
                                Text(item.musicName)
                                    .foregroundColor(Color("black"))
                                    .font(Font.custom("Gotham-Meidum", size: 16))
                                    .frame(width:125, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .padding(.vertical)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
       Text("")
    }
}




