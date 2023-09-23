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
