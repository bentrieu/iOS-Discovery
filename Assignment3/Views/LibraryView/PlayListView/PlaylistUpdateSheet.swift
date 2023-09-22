//
//  PlaylistUpdateSheet.swift
//  Assignment3
//
//  Created by DuyNguyen on 15/09/2023.
//

import SwiftUI

struct PlaylistUpdateSheet: View {
    @Environment (\.dismiss) var dismiss
    let parentPresentationMode: Binding<PresentationMode>
    
    @Binding var showAddTracksToPlaylistView: Bool
    @Binding var showEditPlaylistView : Bool
    
    @StateObject var playlistManager = PlaylistManager.instance
    let playlist: DBPlaylist
    
    var body: some View {
        ZStack{
            Color("white")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 35){
                PlaylistRowView(imgDimens: 60, titleSize: 23, subTitleSize: 18, playlist: playlist)
                    .padding(.top, 30)
                    .padding(.bottom, -10)
                
                Divider()
                    .overlay(Color("black"))
                
                //MARK: - PLAY BUTTON
                Group{
                    Button {
                        dismiss()
                        
                    } label: {
                        ButtonRowView(iconName: "play",iconSize: 23, text: "Listen to this playlist")
                    }
                    //MARK: - ADD TO PLAYLIST BUTTON
                    Button {
                        withAnimation {
                            showAddTracksToPlaylistView = true
                        }
                        dismiss()
                    } label: {
                        ButtonRowView(iconName: "plus.square",iconSize: 23, text: "Add to this playlist")
                    }
                    //MARK: - EDIT PLAYLIST BUTTON
                    Button {
                        dismiss()
                        showEditPlaylistView = true
                    } label: {
                        ButtonRowView(iconName: "pencil",iconSize: 23, text: "Edit playlist")
                    }
                    //MARK: - DELETE PLAYLIST BUTTON
                    Button {
                        Task{
                            //delete playlist on firestore
                            do{
                                //try await playlistManager.deletePla
                            }catch{
                                print(error)
                            }
                            //fetch change to local playlists array
                            do{
                                playlistManager.playlists = try await playlistManager.getAllPlaylist()
                            }catch {
                                print(error)
                            }
                        }
                        dismiss()
                        self.parentPresentationMode.wrappedValue.dismiss()

                    } label: {
                        ButtonRowView(iconName: "xmark",iconSize: 23, text: "Delete playlist")
                    }
                }.padding(.horizontal)
                Spacer()
            }.modifier(PagePadding())
        }
    }
}

struct ButtonRowView: View{
    let iconName: String
    let iconSize: CGFloat
    let text: String
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: iconName)
                .resizable()
                .modifier(Icon())
                .frame(width: iconSize)
            
            Text(text)
                .font(.custom("Gotham-Medium", size: 21))
                .modifier(BlackColor())
        }
    }
}

//struct PlaylistUpdateSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistUpdateSheet(parentPresentationMode: .constant(PresentationMode.self), showAddTracksToPlaylistView: .constant(false) ,imgName: "testImg", playlistName: "Playlist Name", numOfTracks: 4)
//    }
//}
