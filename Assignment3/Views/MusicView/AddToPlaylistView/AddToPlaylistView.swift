//
//  AddToPlayListSheet.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct AddToPlaylistView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var playListManager = PlaylistManager.instance
//    var playlistSearchResult : [DBPlaylist]{
//        return playListManager.searchPlaylistByName(input: searchInput)
//    }
    
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
                
                
               
                
                HStack{
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
                        .frame(width: UIScreen.main.bounds.width/1.6, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(searchActive ? 0 : 0.4))
                        )
                    }
                    
                    Spacer()
                    
                    //MARK: - SORT BUTTON
                    Button {
                        
                    } label: {
                        Text("Sort")
                            .font(.custom("Gotham-Medium", size: 20))
                            .modifier(BlackColor())
                            .frame(width: UIScreen.main.bounds.width/4, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(searchActive ? 0 : 0.4))
                            )
                    }
                }
                .offset(y: searchActive ? -UIScreen.main.bounds.height/30 : 0)
                .opacity(searchActive || addNewPlaylist ? 0 : 1)
                .frame(height: searchActive || addNewPlaylist ? 0 : nil)
                .disabled(searchActive || addNewPlaylist)
                .animation(.easeOut, value: searchActive)
                
                
                
                //MARK: - LIST OF PLAYLISTS
                List{
//                    ForEach(playlistSearchResult.isEmpty ? playListManager.playlists : playlistSearchResult, id: \.playlistId) {playlist in
                    ForEach( playListManager.playlists, id: \.playlistId) {playlist in
                        Button{
                            
                        }label: {
                            PlaylistRowView(imgDimens: 40, titleSize: 23, subTitleSize: 17, playlist: playlist)
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
                playListManager.playlists = try await playListManager.getAllPlaylist()
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
