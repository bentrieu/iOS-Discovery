//
//  LibraryView.swift
//  Assignment3
//
//  Created by DuyNguyen on 14/09/2023.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack{
            Color("white")
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack(spacing:45){
                    //MARK: - HEADER
                    HStack(){
                        Image("testImg")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .modifier(Img())
                            .clipShape(Circle())
                        Text("Your Library")
                            .font(.custom("Gotham-Bold", size: 28))
                            .modifier(BlackColor())
                        Spacer()
                        
                        //MARK: - SEARCH BUTTON
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 25)
                                .foregroundColor(Color("black"))
                        }
                        
                        //MARK: - ADD NEW PLAYLIST BUTTON
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 25)
                                .foregroundColor(Color("black"))
                        }
                        
                        
                    }
                    Divider()
                        .overlay(Color("black"))
                    
                    //MARK: - LIST OF PLAYLIST
                    
                    List{
                        NavigationLink (destination: PlaylistView(imgName: .constant("testImg"), playlistName: .constant("Playlist Name"), numOfTracks: .constant(4))){
                            ListRowView(imgName: "testImg", imgDimens: 65, title: "Playlist Name", titleSize: 25, subTitle: "Num of Tracks", subTitleSize: 18)
                        }                    .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        
                    }.listStyle(PlainListStyle())
                }
                .modifier(PagePadding())
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
