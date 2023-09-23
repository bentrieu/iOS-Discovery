//
//  SwiftUIView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct MusicView: View {
    @State var musics : [Music] = []
    @StateObject var musicManager = MusicManager.instance
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended Music")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(musics, id: \.musicId) { item in
                        Button {
                            //set the current music to the selected music
                            musicManager.currPlaying = item

                            //make sure the music list contain the selected music itself
                            musicManager.musicList.removeAll()
                            musicManager.musicList.append(item)

                            //play the music
                            musicManager.play()
                               
                        } label: {
                            VStack(alignment: .leading){
                                SquareView(imageUrl: item.imageUrl!, size: 110)
                                VStack(alignment: .leading, spacing: -5){
                                    Text(item.musicName!)
                                        .font(Font.custom("Gotham-Bold", size: 13))
                                        .padding(.top,5)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                                .offset(y:-10)
                                .foregroundColor(Color("black"))
                                .frame(width: 110,alignment: .leading)
                            }
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .onAppear{
            Task {
                do {
                    self.musics = try await MusicViewModel.shared.getMusicListFromAlbum("fC5YS4zCnX0m6Ob8V17I")
                    // Handle the albums
                } catch {
                    // Handle any errors that occur during the asynchronous operation
                    print("Error: \(error)")
                }
            }
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}




