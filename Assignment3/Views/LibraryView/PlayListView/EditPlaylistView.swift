/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Minh Quan, Dinh Huu Gia Phuoc, Vu Gia An, Trieu Hoang Khang, Nguyen Tran Khang Duy
  ID: s3877969, s3878270, s3926888, s3878466, s3836280
  Created  date: 10/9/2023
  Last modified: 23/9/2023
  Acknowledgement:
https://rmit.instructure.com/courses/121597/pages/w9-whats-happening-this-week?module_item_id=5219569
https://rmit.instructure.com/courses/121597/pages/w10-whats-happening-this-week?module_item_id=5219571
*/

import PhotosUI
import SwiftUI

@MainActor
final class PlaylistViewModel: ObservableObject {
    
    func savePlaylistImage(item: PhotosPickerItem, playlistId: String) async throws {
        let playlist = try await PlaylistManager.instance.getPlaylist(playlistId: playlistId)
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            let (path, name) = try await StorageManager.instance.savePlaylistImage(data: data, playlistId: playlist.playlistId)
            print("success")
            print(path)
            print(name)
            let url = try await StorageManager.instance.getUrlForImage(path: path)
            try await PlaylistManager.instance.updatePlaylistPhoto(playlistId: playlist.playlistId, photoUrl: url.absoluteString)
        }
    }
}

struct EditPlaylistView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var playlistManager = PlaylistManager.instance
    @StateObject var playlistviewModel = PlaylistViewModel()
    let playlist: DBPlaylist
    
    @State var nameInput = ""
    @State var photoUrl = ""
    @State var musicsIdBeforeEdit = [String]()
    var playlistTracks : [Music]{
        return playlistManager.getAllMusicsInPlaylist(playlistId: playlist.playlistId)
    }
    @State var showErrNotification = false
    @State private var item: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var loading = true
    
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
                            saveUserInfo()
                            dismiss()
                        }

                    } label: {
                        Text("Save")
                            .font(.custom("Gotham-Medium", size: 23))
                            .modifier(BlackColor())
                    }
                }
                
                //MARK: - THUMBNAIL IMG
                if let selectedImage{
                    selectedImage
                        .resizable()
                        .modifier(PlayListImageModifer())
                }else{
                    AsyncImage(url: URL(string: photoUrl)) { phase in
                        if let image = phase.image {
                            // if the image is valid
                            image
                                .resizable()
                                .onAppear{
                                    loading = false
                                }
                        } else {
                            //appears as placeholder & error image
                            Image(systemName: "photo")
                                .resizable()
                                .onAppear{
                                    loading = false
                                }
                        }
                    }
                    .modifier(PlayListImageModifer())
                }
            
                //MARK: - CHANGE IMAGE BUTTON
                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
                    Text("Change photo")
                        .font(.custom("Gotham-Medium", size: 18))
                        .modifier(BlackColor())
                }
                
         
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
            
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
            
            
            
        }
        .onAppear {
            nameInput = playlist.name ?? ""
            photoUrl = playlist.photoUrl!
            musicsIdBeforeEdit = playlist.musics ?? [String]()
        }
        .onChange(of: item, perform: { newValue in
//            self.isContentNotEdited  = false
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                        return
                    }
                }
            }
        })
    }
    func saveUserInfo(){
        if let item{
            Task{
                do{
                    //update playlist name and img url on firestore
                    try await playlistviewModel.savePlaylistImage(item: item, playlistId: playlist.playlistId)
                    //fetch change to local array
                    playlistManager.playlists = try await playlistManager.getAllPlaylist()
                    let _ = print(playlist)
                    playlistManager.id = UUID()
                }catch{
                    print(error)
                }
            }
        }
        
        Task{
            do{
                //update playlist name and img url on firestore
                try await playlistManager.updatePlaylistName(playlistId: playlist.playlistId, name: nameInput)
                //fetch change to local array
                playlistManager.playlists = try await playlistManager.getAllPlaylist()
            }catch{
                print(error)
            }
        }
       
    }
}



//struct EditPlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditPlaylistView(playlist: PlaylistManager.instance.getPlaylist(playlistId: "v8AtiDouY7nv1napA7Uv"))
//    }
//}



