//
//  AlbumPageView.swift
//  Assignment3
//
//  Created by DuyNguyen on 19/09/2023.
//

import SwiftUI

struct AlbumPageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var album : Album
    
    @State var playMusicAvtive = false
    @StateObject var musicManager  = MusicManager.instance
    @State var firstPlaying = true
    var numOfTracks : Int{
        return album.musicList.count
    }
    
    //MARK: - BACK BUTTON
    var btnBack : some View { Button(action: {
        
        self.presentationMode.wrappedValue.dismiss()
        
    }) {
        Image(systemName: "arrow.backward")
            .resizable()
            .modifier(Icon())
            .frame(width: 25)
    }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30){
                    //MARK: - THUMBNAIL IMG
                    SquareView(imageUrl: album.imageUrl!, size: 225)
                    
                    HStack{
                        VStack(alignment: .leading){
                            //MARK: - PLAYLIST NAME
                            Text(album.title!)
                                .font(.custom("Gotham-Black", size: 35))
                                .modifier(OneLineText())
                            Text("\(numOfTracks) track(s)")
                                .font(.custom("Gotham-Medium", size: 18))
                                .modifier(OneLineText())
                        }
                        Spacer()
                        //MARK: - PLAY BUTTON
                        Button {
                            if firstPlaying{
                                musicManager.currPlaying = musicManager.musicList[0]
                                musicManager.play()
                                firstPlaying = false
                            }else{
                                musicManager.pauseMusic()
                            }
                            
                        } label: {
                            Image(systemName: musicManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, alignment: .center)
                                .foregroundColor(Color("green"))
                                .background(
                                    Circle()
                                        .fill(Color(.black))
                                )
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray)
                    
                    //MARK: - LIST OF TRACKS
                    VStack {
                        ForEach(musicManager.musicList, id: \.musicId) { item in
                            Button {
                                musicManager.currPlaying = item
                                musicManager.play()
                                
                            } label: {
                                MusicRowView(imgDimens: 45, titleSize: 16, subTitleSize: 12, music: item)
                            }
                        }
                    }
                    Spacer()
                }
                .modifier(PagePadding())
            }
        }
        .task{
            do {
                MusicManager.instance.musicList = try await MusicViewModel.shared.getMusicListFromAlbum(album.albumId)
                
            } catch {
                // Handle the error
                print("Error: \(error)")
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(album.title!)
        .navigationBarTitleDisplayMode(.inline)
        //        .navigationBarItems(leading: CustomNavigationButton())
        
    }
    
}

struct AlbumPageView_Previews: PreviewProvider {
    static var previews: some View {
        
        AlbumPageView(album: albumSample)
        
    }
}

let albumSample = Album(albumId: "ecmL9AZEFHgQ9Ritrc69",
                        imageUrl: "https://upload.wikimedia.org/wikipedia/en/5/53/Maroon_5_-_V_%28Official_Album_Cover%29.png",
                        title: "99%",
                        type: "Rap",
                        musicList: ["OusE6eoQy5b765gHbIQB ","lB3DFP1fKpgNjeRaeQit"])
