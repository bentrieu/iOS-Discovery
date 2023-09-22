//
//  PlaylistVIew.swift
//  Assignment3
//
//  Created by DuyNguyen on 15/09/2023.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var playlistManager = PlaylistManager.instance
    
    let playlistId : String
    var playlistName: String{
        return playlistManager.playlists.first(where: {$0.playlistId == playlistId})?.name ?? ""
    }
    var playlistTracks : [Music]{
        return playlistManager.getAllMusicsInPlaylist(playlistId: playlistId)
    }
    
    var musicSearchResult : [Music]{
        if playlistTracks.isEmpty{
            return [Music]()
        }else{
            return playlistManager.searchMusicInAListByNameAndArtist(input: searchInput, musics: playlistTracks)
        }
    }
    
    @State var playMusicAvtive = false
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
                AddTracksToPlayListView(showView: $showAddTracksToPlaylistView, playlistId: playlistId)
            }else{
                
                VStack(spacing: searchActive ? 0 :30){
                    //MARK: - THUMBNAIL IMG
                    Image("testImg")
                        .resizable()
                        .frame(width: searchActive ? 0 : UIScreen.main.bounds.width/1.5,height:searchActive ? 0 : UIScreen.main.bounds.width/1.6)
                    
                        .opacity(searchActive ? 0 : 1)
                        .modifier(Img())
                    
                    HStack{
                        VStack(alignment: playlistTracks.isEmpty ? .center : .leading){
                            
                            //MARK: - PLAYLIST NAME
                            Text(playlistName)
                                .font(.custom("Gotham-Bold", size: 30))
                                .modifier(OneLineText())
                            Text("\(playlistTracks.count) track(s)")
                                .font(.custom("Gotham-Me", size: 20))
                                .modifier(OneLineText())
                        }
                        
                        if !playlistTracks.isEmpty{
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
                                    
                                }label: {
                                    MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: music)
                                }
                                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                
                            }
                            
                        }
                        .listStyle(PlainListStyle())
                        .offset(y: searchActive ? -30 : 0)
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
//                            PlaylistUpdateSheet(parentPresentationMode: presentationMode,showAddTracksToPlaylistView: $showAddTracksToPlaylistView, showEditPlaylistView: $showEditPlaylistView, imgName: imgName, playlistName: playlistName, numOfTracks: numOfTracks)
//                                .presentationDetents([.medium])
                              
                        }
                        
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $showEditPlaylistView) {
            EditPlaylistView()
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
            .frame(width: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal)
        }


    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlistId: "v8AtiDouY7nv1napA7Uv")
    }
}
