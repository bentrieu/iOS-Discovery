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

struct AddToPlaylistView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var playlistManager = PlaylistManager.instance
    var playlistSearchResult : [DBPlaylist]{
        
        return searchInput.isEmpty ? playlistManager.playlists : playlistManager.searchPlaylistByName(input: searchInput)
    }
    
    @State var addNewPlaylist = false
    
    @State var searchActive = false
    @State var searchInput = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack(spacing: searchActive ? 5 : addNewPlaylist ? 0 : 30){
                //MARK: - HEADER
                HStack{
                    Button {
                        if searchActive{
                            searchInput = ""
                            searchActive = false
                        }else if addNewPlaylist{
                            addNewPlaylist = false
                        }else{
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .modifier(Icon())
                            .frame(height: 16)
                            .rotationEffect(.degrees(searchActive || addNewPlaylist ? 90 : 0), anchor: UnitPoint(x: 0.4, y: 0.15))
                            .animation(.easeInOut, value: searchActive || addNewPlaylist)
                    }
                    
                    
                    Spacer()
                    
                    
                    //MARK: - SEARCH BAR
                    FocusedSearchBarView(searchInput: $searchInput, searchActive: $searchActive,prompt: "Find playlist")
                        .opacity(searchActive ? 1 : 0)
                        .frame(width: searchActive ? nil : 0, height: searchActive ? nil : 0)
                        .disabled(!searchActive)
                    
                    //MARK: - VIEW TITLE
                    Text(addNewPlaylist ? "New playlist" : "Add To Playlist")
                        .font(.custom("Gotham-Bold", size: 22))
                        .modifier(BlackColor())
                        .offset(x: addNewPlaylist ? -12 : -7)
                        .animation(.easeIn, value: addNewPlaylist)
                        .opacity(searchActive ? 0 : 1)
                        .frame(width: searchActive ? 0 : nil, height: searchActive ? 0 : nil)
                    
                    if !searchActive{
                        Spacer()
                    }
                }
                
                //MARK: - NEW PLAYLIST BUTTON
                Button{
                    addNewPlaylist = true
                }label: {
                    Text("New playlist")
                        .font(.custom("Gotham-Bold", size: 20))
                        .modifier(BlackColor())
                        .padding(.vertical)
                        .padding(.horizontal,30)
                        .background(
                            Capsule().stroke(Color("black"))
                                .opacity(addNewPlaylist ? 0 : 1)
                                .animation(nil, value: addNewPlaylist)
                        )
                    
                }
                .opacity(searchActive || addNewPlaylist ? 0 : 1)
                .frame(height: searchActive || addNewPlaylist ? 0 : nil)
                .disabled(searchActive || addNewPlaylist)
                .offset(y: addNewPlaylist ? -20 : 0)
                .animation(.easeOut, value: addNewPlaylist)
                
                
                
                
                //MARK: - SEARCH PLAYLIST BUTTON
                Button {
                    searchActive = true
                } label: {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 20)
                            .bold()
                            .foregroundColor(Color("black"))
                        Text("Find playlist")
                            .font(.custom("Gotham-Medium", size: 20))
                            .modifier(BlackColor())
                    }
                    .frame(width: UIScreen.main.bounds.width/1.2, height: 53)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(searchActive ? 0 : 0.4))
                    )
                }
                
                .offset(y: searchActive ? -UIScreen.main.bounds.height/30 : 0)
                .opacity(searchActive || addNewPlaylist ? 0 : 1)
                .frame(height: searchActive || addNewPlaylist ? 0 : nil)
                .disabled(searchActive || addNewPlaylist)
                .animation(.easeOut, value: searchActive)
                
                
                if (!playlistManager.playlists.isEmpty && searchInput.isEmpty) || (!playlistSearchResult.isEmpty && !searchInput.isEmpty){
                    //MARK: - LIST OF PLAYLISTS
                    List{
                        ForEach(playlistSearchResult, id: \.playlistId) {playlist in
                            Button{
                                Task {
                                    do {
                                        try await playlistManager.addMusicToPlaylist(musicId: MusicManager.instance.currPlaying.musicId, playlistId: playlist.playlistId)
                                    } catch {
                                        print(error)
                                    }
                                }
                                dismiss()
                            }label: {
                                PlaylistRowView(imgDimens: 60, titleSize: 23, subTitleSize: 18, playlist: playlist)
                            }
                            .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .animation(.easeInOut, value: searchActive)
                    .opacity(addNewPlaylist ? 0 : 1)
                    .frame(height: addNewPlaylist ? 0 : nil)
                    .disabled(addNewPlaylist)
                }
                if(addNewPlaylist){
                    Spacer()
                }
                
                //MARK: NEW PLAYLIST VIEW
                NewPlaylistView(showView: $addNewPlaylist)
                    .opacity(addNewPlaylist ? 1 : 0)
                    .frame(height: addNewPlaylist ? nil : 0)
                    .disabled(!addNewPlaylist)
                    .animation(.easeOut, value: addNewPlaylist)
                
                Spacer()
            }
            .modifier(PagePadding())
        }
        .task {
            do{
                playlistManager.playlists = try await playlistManager.getAllPlaylist()
            } catch {
                // Handle the error
                print("Error: \(error)")
                
            }
        }
    }
}

struct AddToPlayListSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddToPlaylistView()
    }
}
