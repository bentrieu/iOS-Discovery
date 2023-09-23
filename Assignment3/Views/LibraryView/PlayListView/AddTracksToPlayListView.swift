//
//  AddTracksToPlayListView.swift
//  Assignment3
//
//  Created by DuyNguyen on 15/09/2023.
//

import SwiftUI

struct AddTracksToPlayListView: View {
    
    @Binding var showView: Bool
    @StateObject var playlistManager = PlaylistManager.instance
    
    let playlistId : String
    var playlistTracks : [Music]{
        return playlistManager.getAllMusicsInPlaylist(playlistId: playlistId)
    }
    var trackSearchList: [Music]{   //list contains musics have not been added in playlist
        if playlistTracks.isEmpty{
            return MusicViewModel.shared.musics
        }
        else{
            var result = [Music]()
            var isIncludedInPlaylist = false
            for music in MusicViewModel.shared.musics{
                isIncludedInPlaylist = false
                for track in playlistTracks{
                    if music.musicId == track.musicId{
                        isIncludedInPlaylist = true
                        break
                    }
                }
                if !isIncludedInPlaylist{
                    result.append(music)
                }
            }
            return result
        }
    }
    
    var trackSearchResult : [Music]{
        if trackSearchList.isEmpty{
            return [Music]()
        }else{
            return playlistManager.searchMusicInAListByNameAndArtist(input: searchInput, musics: trackSearchList)
        }
    }
    
    @State var searchInput = ""
    var body: some View {
        VStack(spacing: 20){
            //MARK: - HEADER
            HStack{
                Button {
                    showView = false
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .modifier(Icon())
                        .frame(width: 25)
                }
                
                
                Spacer()
                
                Text("Add to this playlist")
                    .font(.custom("Gotham-Bold", size: 22))
                    .modifier(BlackColor())
                    .offset(x: -10)
                Spacer()
            }.padding(.bottom, 10)
            
            //MARK: - SEARCH BAR
            SearchBarView(searchInput: $searchInput, prompt: "Search")
            
            
            //MARK: - SEARCH NOTIFICATION
            if trackSearchList.isEmpty {
                Spacer()
                Text("All tracks have been added to this playlist")
                    .font(.custom("Gotham-Black", size: 20))
                    .modifier(BlackColor())
                    .multilineTextAlignment(.center)
                Spacer()
            }else{
                if trackSearchResult.isEmpty{
                    Text("Couldn't find '\(searchInput)'")
                        .font(.custom("Gotham-Black", size: 22))
                        .modifier(BlackColor())
                        .multilineTextAlignment(.center)
                    Text("Trying searching again using a different spelling or keyword")
                        .font(.custom("Gotham-Medium", size: 17))
                        .modifier(BlackColor())
                        .multilineTextAlignment(.center)
                        .offset(y : -20)
                    Spacer()

                }else{
                    //MARK: - TRACK LIST
                    List{
                        ForEach(trackSearchResult) { track in
                            Button{
                                searchInput = ""
                                //remove focus on search bar when tap on other views
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                
                                Task{
                                    //update to firestore
                                    do{
                                       try await playlistManager.addMusicToPlaylist(musicId: track.musicId, playlistId: playlistId)
                                    } catch {
                                        print(error)
                                    }
                                    //fetch change to local playlists array
                                    do{
                                        playlistManager.playlists = try await playlistManager.getAllPlaylist()
                                    }catch {
                                        print(error)
                                    }
                                }
                            }label: {
                                HStack{
                                    MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: track)
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .modifier(Icon())
                                        .frame(width: 25)
                                        .offset(x: -10)
                                }
                            }
                            .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal,10)
                    .listStyle(PlainListStyle())
                    .background(
                        Color(.gray).opacity(0.3)
                    )
                    .cornerRadius(15)
                }
            }
            
            
            
        }.modifier(PagePadding())
    }
}

struct AddTracksToPlayListView_Previews: PreviewProvider {
    static var previews: some View {
        AddTracksToPlayListView(showView: .constant(true), playlistId: "")
    }
}
