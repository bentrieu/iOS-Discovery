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

import SwiftUI

struct PlaylistView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var playlistManager = PlaylistManager.instance
    @StateObject var musicManager  = MusicManager.instance
    
    let playlist : DBPlaylist
    
    var playlistTracks : [Music]{
        return playlistManager.getAllMusicsInPlaylist(playlistId: playlist.playlistId)
    }
    
    var musicSearchResult : [Music]{
        if playlistTracks.isEmpty{
            return [Music]()
        }else{
            return playlistManager.searchMusicInAListByNameAndArtist(input: searchInput, musics: playlistTracks)
        }
    }
    
    @State var playMusicActive = false
    @State var firstPlaying = true
    @State var searchActive = false
    @State var searchInput = ""
    
    @State var showPlaylistUpdateSheet = false
    @State var showAddTracksToPlaylistView = false
    @State var showEditPlaylistView = false
  
    //MARK: - BACK BUTTON
    var btnBack : some View { Button(action: {
        if searchActive{
            searchInput = ""
            withAnimation {
                searchActive = false
            }
            //remove focus on search bar when tap on other views
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }else{
            self.presentationMode.wrappedValue.dismiss()
        }
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
            
            if showAddTracksToPlaylistView{
                AddTracksToPlayListView(showView: $showAddTracksToPlaylistView, playlistId: playlist.playlistId)
            }else{
                
                VStack(spacing: searchActive ? 0 :30){
                    //MARK: - THUMBNAIL IMG
                    AsyncImage(url: URL(string: playlist.photoUrl!)) { phase in
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
                    .id(playlistManager.id)
                    .modifier(Img())
                    .frame(width: searchActive ? 0 : UIScreen.main.bounds.width/1.5,height:searchActive ? 0 : UIScreen.main.bounds.width/1.5)
                    .clipped()
                    .overlay(
                        Rectangle()
                            .stroke(.gray, lineWidth: 4)
                    )
                    .opacity(searchActive ? 0 : 1)
                    
                    
                    HStack{
                        VStack(alignment: playlistTracks.isEmpty ? .center : .leading){
                            
                            //MARK: - PLAYLIST NAME
                            Text(playlist.name ?? "")
                                .font(.custom("Gotham-Black", size: 35))
                                .modifier(OneLineText())
                            Text("\(playlistTracks.count) track(s)")
                                .font(.custom("Gotham-Book", size: 20))
                                .modifier(OneLineText())
                        }
                        
                        if !playlistTracks.isEmpty{
                            Spacer()
                            //MARK: - PLAY BUTTON
                            Button {
                                if firstPlaying{
                                    musicManager.musicList.removeAll()
                                    musicManager.musicList = playlistTracks
                                    musicManager.currPlaying = playlistTracks[0]
                                    musicManager.play()
                                    firstPlaying = false
                                }else{
                                    musicManager.pauseMusic()
                                }
                                
                                playMusicActive.toggle()
                            } label: {
                                Image(systemName: playMusicActive ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, alignment: .center)
                                    .foregroundColor(.accentColor)
                                    .background(
                                        Circle()
                                            .fill(Color("black"))
                                    )
                            }
                        }
                        
                    }
                    .offset(y: searchActive ? -50 : 0)
                    .frame(height: searchActive ? 0 : nil)
                    .opacity(searchActive ? 0 : 1)
                    
                    
                    if playlistTracks.isEmpty{  //play list has no track
                        Divider()
                            .frame(height: 1)
                            .overlay(Color("black"))
                        
                        
                        //MARK: - ADD FIRST TRACK BUTTON
                        Text("Let's start building your playlist")
                            .font(.custom("Gotham-Medium", size: 20))
                            .modifier(BlackColor())
                        Button {
                            withAnimation {
                                showAddTracksToPlaylistView = true
                            }
                        } label: {
                            AddToPlaylistButtonView(isMusicListEmpty: true)
                        }
                        Spacer()
                    }else{  //playlist has track
                        if musicSearchResult.isEmpty{
                            //MARK: - SEARCH NOTIFICATION
                            Text("No results found for '\(searchInput)'")
                                .font(.custom("Gotham-Black", size: 22))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                            Text("Check the spelling, or try different keywords.")
                                .font(.custom("Gotham-Medium", size: 17))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                            Spacer()
                        }else{
                            //MARK: - LIST OF TRACKS
                            List{
                                //MARK: ADD TO PLAYLIST BUTTON
                                Button{
                                    withAnimation {
                                        showAddTracksToPlaylistView = true
                                    }
                                    
                                }label: {
                                    AddToPlaylistButtonView(isMusicListEmpty: false)
                                }
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .frame(height: searchActive ? 0 : nil)
                                .opacity(searchActive ? 0 : 1)
                                .disabled(searchActive)
                                
                                
                                ForEach(musicSearchResult) { music in
                                    
                                    Button{
                                        if firstPlaying{
                                            musicManager.musicList.removeAll()
                                            musicManager.musicList = playlistTracks
                                            firstPlaying = false
                                        }
                                        musicManager.currPlaying = music
                                        musicManager.play()
                                        playMusicActive = true
                                        
                                    }label: {
                                        MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: music)
                                    }
                                    .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    
                                }
                                //MARK: - DELETE PLAYLIST ITEM FUNCTION
                                .onDelete { offsets in
                                    Task{
                                        for index in offsets{
                                            //delete tracks in playlist on firestore
                                            do{
                                                try await playlistManager.removeMusicFromPlaylist(musicId: musicSearchResult[index].musicId, playlistId: playlist.playlistId)
                                            }catch{
                                                print(error)
                                            }
                                            //fetch change to local playlists array
                                            do{
                                                playlistManager.playlists = try await playlistManager.getAllPlaylist()
                                            }catch{
                                                print(error)
                                            }
                                        }
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                            .offset(y: searchActive ? -30 : 0)
                        }
                    }
                    
                }
                .modifier(PagePadding())
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: btnBack)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        //MARK: - SEARCH BAR
                        if !playlistTracks.isEmpty{
                            SearchBarView(searchInput: $searchInput, prompt: "Find in playlist")
                                .onTapGesture {
                                    withAnimation {
                                        searchActive = true
                                    }
                                }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        //MARK: SHOW MORE OPTIONS BUTTON
                        Button {
                            showPlaylistUpdateSheet = true
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .modifier(Icon())
                                .rotationEffect(.degrees(90))
                        }
                        .frame(width: searchActive ? 0 : nil)
                        .opacity(searchActive ? 0 : 1)
                        .disabled(searchActive)
                        .animation(nil)
                        .sheet(isPresented: $showPlaylistUpdateSheet) {
                            PlaylistUpdateSheet(parentPresentationMode: presentationMode,showAddTracksToPlaylistView: $showAddTracksToPlaylistView, showEditPlaylistView: $showEditPlaylistView, firstPlaying: $firstPlaying, playMusicActive: $playMusicActive,playlistTracks: playlistTracks, playlist: playlist)
                                .presentationDetents([.medium])
                            
                        }
                        
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $showEditPlaylistView) {
            EditPlaylistView(playlist: playlist)
        }
    }
}

struct AddToPlaylistButtonView: View {
    let isMusicListEmpty : Bool
    
    var body: some View {
        if isMusicListEmpty{
            Text("Add to this playlist")
                .font(.custom("Gotham-Bold", size: 20))
                .modifier(BlackColor())
                .padding(.vertical)
                .padding(.horizontal,30)
                .background(
                    Capsule().stroke(Color("black"))
                )
        }else{
            HStack(spacing: UIScreen.main.bounds.width/25) {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .modifier(Icon())
                    .foregroundColor(Color("black"))
                Text("Add to this playlist")
                    .font(.custom("Gotham-Medium", size: 21))
                    .modifier(OneLineText())
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        
        
    }
}

//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView(playlist: PlaylistManager.instance.getPlaylist(playlistId: "v8AtiDouY7nv1napA7Uv"))
//    }
//}
