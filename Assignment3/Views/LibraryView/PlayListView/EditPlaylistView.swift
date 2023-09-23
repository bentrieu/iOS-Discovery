//
//  EditPlaylistView.swift
//  Assignment3
//
//  Created by DuyNguyen on 17/09/2023.
//

import SwiftUI

struct EditPlaylistView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var playlistManager = PlaylistManager.instance
    let playlist: DBPlaylist
    
    @State var nameInput = ""
    @State var photoUrl = ""
    @State var musicsIdBeforeEdit = [String]()
    var playlistTracks : [Music]{
        return playlistManager.getAllMusicsInPlaylist(playlistId: playlist.playlistId)
    }
    @State var showErrNotification = false
    
    var body: some View {
        ZStack{
            Color("white")
            VStack(spacing: 20){
                HStack{
                    //MARK: - CLOSE BUTTON
                    Button {
                        Task{
                            do{
                                //reset the musics in playlist on firestore as before editting when tap cancel button
                                try await playlistManager.setMusicsToPlaylist(musicIds: musicsIdBeforeEdit, playlistId: playlist.playlistId)
                                //fetch change to local array
                                playlistManager.playlists = try await playlistManager.getAllPlaylist()
                            }catch{
                                print(error)
                            }
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 23)
                        
                    }
                    Spacer()
                    
                    //MARK: - HEADER
                    Text("Edit Playlist")
                        .font(.custom("Gotham-Bold", size: 21))
                        .modifier(BlackColor())
                        .offset(x: 13)
                    
                    Spacer()
                    //MARK: - SAVE BUTTON
                    Button {
                        if nameInput.isEmpty{
                            showErrNotification = true
                        }
                        else{
                            Task{
                                do{
                                    //update playlist name and img url on firestore
                                    try await playlistManager.updatePlaylistName(playlistId: playlist.playlistId, name: nameInput)
                                    try await playlistManager.updatePlaylistPhoto(playlistId: playlist.playlistId, photoUrl: photoUrl)
                                    //fetch change to local array
                                    playlistManager.playlists = try await playlistManager.getAllPlaylist()
                                }catch{
                                    print(error)
                                }
                            }
                            dismiss()
                        }

                    } label: {
                        Text("Save")
                            .font(.custom("Gotham-Medium", size: 23))
                            .modifier(BlackColor())
                    }
                }
                
                //MARK: - THUMBNAIL IMG
                AsyncImage(url: URL(string: photoUrl)) { phase in
                    if let image = phase.image {
                        // if the image is valid
                        image
                            .resizable()
                    } else {
                        //appears as placeholder & error image
                        Image(systemName: "photo")
                            .resizable()
                    }
                }
                .modifier(Img())
                .frame(width: UIScreen.main.bounds.width/1.7,height:UIScreen.main.bounds.width/1.7)
                .clipped()
                .overlay(
                    Rectangle()
                        .stroke(.gray, lineWidth: 4)
                )
                
                //MARK: - CHANGE IMAGE BUTTON
                Button{
                    
                }label: {
                    Text("Change image")
                        .font(.custom("Gotham-Medium", size: 18))
                        .modifier(BlackColor())
                }
                .padding(.top, -10)
         
                //MARK: - PLAYLIST NAME
                TextField("", text: $nameInput)
                    .font(.custom("Gotham-Black", size: 38))
                    .modifier(BlackColor())
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .background(
                        Color.clear
                            .overlay(
                                VStack{
                                    Divider()
                                        .frame(height: 1)
                                        .overlay(showErrNotification ? Color.red : Color("black"))
                                    Text("Please give your playlist a name")
                                        .font(.custom("Gotham-Medium", size: 15))
                                        .foregroundColor(.red)
                                        .opacity(showErrNotification ? 1 : 0)
                                }
                                    .offset(x: 0, y: 30)
                            )
                    )
                    .padding(.bottom,10)
                    .onChange(of: nameInput) { newValue in
                        showErrNotification = false
                    }
                if playlistTracks.isEmpty{
                    Text("There is no track in this playlist")
                        .font(.custom("Gotham-BookItalic", size: 20))
                        .modifier(BlackColor())
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                else{
                //MARK: - LIST OF TRACKS
                List{
                    ForEach(playlistTracks) { track in
                        HStack (){
                            
                            MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: track)
                            
                            Spacer()
                            
                            //MARK: DELETE TRACK BUTTON
                            Button{
                                //remove focus on textfield when tap on other views
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                Task{
                                    //remove track in playlist on firestore
                                    do{
                                        try await playlistManager.removeMusicFromPlaylist(musicId: track.musicId, playlistId: playlist.playlistId)
                                    }catch{
                                        print(error)
                                    }
                                    //fetch change to local array
                                    do{
                                        playlistManager.playlists = try await playlistManager.getAllPlaylist()
                                    }catch{
                                        print(error)
                                    }
                                }

                                
                            }label: {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .modifier(Icon())
                                    .frame(width: 33)
                                
                            }
                        }
                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
                
            }
            .modifier(PagePadding())
        }
        .onAppear {
            nameInput = playlist.name ?? ""
            photoUrl = playlist.photoUrl!
            musicsIdBeforeEdit = playlist.musics ?? [String]()
        }
    }
}



//struct EditPlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPlaylistView(playlist: PlaylistManager.instance.getPlaylist(playlistId: "v8AtiDouY7nv1napA7Uv"))
//    }
//}
