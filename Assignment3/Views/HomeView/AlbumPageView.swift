//
//  AlbumPageView.swift
//  Assignment3
//
//  Created by DuyNguyen on 19/09/2023.
//

import SwiftUI

struct AlbumPageView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let imgName: String
    let albumName:String
    let numOfTracks: Int
    
    @State var playMusicAvtive = false
    
    
    //MARK: - BACK BUTTON
    var btnBack : some View { Button(action: {
        
        self.presentationMode.wrappedValue.dismiss()
        
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
            
            
            VStack{
                //MARK: - THUMBNAIL IMG
                Image(imgName)
                    .resizable()
                    .frame(height: UIScreen.main.bounds.width/1.5)
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                    .padding(.bottom, -50)
                
                VStack(spacing: 30){
                    HStack{
                        VStack(alignment: .leading){
                            //MARK: - PLAYLIST NAME
                            Text(albumName)
                                .font(.custom("Gotham-Black", size: 35))
                                .modifier(OneLineText())
                            Text("\(numOfTracks) track(s)")
                                .font(.custom("Gotham-Me", size: 18))
                                .modifier(OneLineText())
                        }
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
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray)
                    
                    //MARK: - LIST OF TRACKS
                    List{
                        Button{
                            
                        }label: {
                            ListRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 21, subTitle: "Artists", subTitleSize: 17)
                        }
                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                        Button{
                            
                        }label: {
                            ListRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 21, subTitle: "Artists", subTitleSize: 17)
                        }
                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                }
                .modifier(PagePadding())

            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
    }
}

struct AlbumPageView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumPageView(imgName: "testImg", albumName: "Hip-hop Viet", numOfTracks: 5)
    }
}
