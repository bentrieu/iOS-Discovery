//
//  EditPlaylistView.swift
//  Assignment3
//
//  Created by DuyNguyen on 17/09/2023.
//

import SwiftUI

struct EditPlaylistView: View {
    @State var playlistName:String = "My Playlist 1"
    
    
    @Environment (\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color("white")
            VStack(spacing: 30){
                HStack{
                    //MARK: - CLOSE BUTTON
                    Button {
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
                        .font(.custom("Gotham-Medium", size: 21))
                        .modifier(BlackColor())
                        .offset(x: 15)
                    
                    Spacer()
                    //MARK: - SAVE BUTTON
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.custom("Gotham-Medium", size: 24))
                            .modifier(BlackColor())
                    }
                }
                
                //MARK: - THUMBNAIL IMG
                Image("testImg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                    .modifier(Img())
                
                //MARK: - PLAYLIST NAME
                TextField("", text: $playlistName)
                    .font(.custom("Gotham-Bold", size: 35))
                    .modifier(BlackColor())
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .background(
                        Color.clear
                            .overlay(
                                VStack{
                                    Divider()
                                        .overlay(Color("black"))
                                        .offset(x: 0, y: 15)
                                }
                            )
                    )
                
                //MARK: - LIST OF TRACKS
                List{
                    HStack (spacing: 25){
                        //MARK: DELETE TRACK BUTTON
                        Button{
                            
                        }label: {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 33)
                            
                        }
                        VStack(alignment: .leading){
                            Text("Track Name")
                                .font(.custom("Gotham-Medium", size: 25))
                                .modifier(OneLineText())
                            Text("Artists")
                                .font(.custom("Gotham-Book", size: 20))
                                .modifier(OneLineText())
                        }
                       
                    }.padding(.horizontal, UIScreen.main.bounds.width/25)
                    .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())

            }
            .modifier(PagePadding())
        }
    }
}



struct EditPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlaylistView()
    }
}