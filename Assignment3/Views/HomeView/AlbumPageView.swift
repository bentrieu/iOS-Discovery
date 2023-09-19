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
            
            
            VStack{
                //MARK: - THUMBNAIL IMG
//                AsyncImage(url: URL(string: album.imageUrl!)) { image in
//                    image
//                        .resizable()
//                        .frame(height: UIScreen.main.bounds.width/1.5)
//                        .scaledToFill()
//                        .ignoresSafeArea(.all)
//                        .padding(.bottom, -50)
//                } placeholder: {
//                    
//                }

                
                VStack(spacing: 30){
                    HStack{
                        VStack(alignment: .leading){
                            //MARK: - PLAYLIST NAME
                            Text(album.title!)
                                .font(.custom("Gotham-Black", size: 35))
                                .modifier(OneLineText())
                            Text("\(numOfTracks) track(s)")
                                .font(.custom("Gotham-Me", size: 18))
                                .modifier(OneLineText())
                        }
                        Spacer()
                        //MARK: - PLAY BUTTON
                        Button {
                            playMusicAvtive.toggle()
                        } label: {
                            Image(systemName: playMusicAvtive ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, alignment: .center)
                                .foregroundColor(.accentColor)
                                .background(
                                    Circle()
                                        .fill(Color(.white))
                                )
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray)
                    
                    //MARK: - LIST OF TRACKS
                  
                    VStack {
                        ForEach(musicManager.musicList, id: \.musicId) { item in
                            NavigationLink {
                                PlayMusicView()
                                    .onAppear{
                                        musicManager.currPlaying = item
                                        musicManager.play()
                                    }
                                   
                            } label: {
                                ListRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: item)
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
    }
  
}

struct AlbumPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumPageView(album: albumSample)
        }
    }
}

let albumSample = Album(albumId: "JkoOm0jVQ81LKSF6HeOP",
                        title: "99%",
                        type: "Rap",
                        musicList: ["OusE6eoQy5b765gHbIQB ","lB3DFP1fKpgNjeRaeQit"])
