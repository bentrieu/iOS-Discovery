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
    
    let imgName:String
    let playlistName:String
    let numOfTracks:Int
    
    var body: some View {
        ZStack{
            Color("white")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 35){
                ListRowView(imgName: imgName, imgDimens: 65, title: playlistName, titleSize: 22, subTitle: "\(numOfTracks) track(s)", subTitleSize: 17)
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
                        showEditPlaylistView = true
                        dismiss()
                    } label: {
                        ButtonRowView(iconName: "pencil",iconSize: 23, text: "Edit playlist")
                    }
                    //MARK: - DELETE PLAYLIST BUTTON
                    Button {
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
