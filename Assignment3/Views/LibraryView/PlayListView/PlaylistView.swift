////
////  PlaylistVIew.swift
////  Assignment3
////
////  Created by DuyNguyen on 15/09/2023.
////
//
//import SwiftUI
//
//struct PlaylistView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    @Binding var imgName: String
//    @Binding var playlistName:String
//    @Binding var numOfTracks: Int
//    
//    @State var playMusicAvtive = false
//    @State var searchActive = false
//    @State var searchInput = ""
//    
//    @State var showPlaylistUpdateSheet = false
//    @State var showAddTracksToPlaylistView = false
//    @State var showEditPlaylistView = false
//    
//    //MARK: - BACK BUTTON
//    var btnBack : some View { Button(action: {
//        if searchActive{
//            searchInput = ""
//            withAnimation {
//                searchActive = false
//            }
//            //remove focus on search bar when tap on other views
//            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
//        }else{
//            self.presentationMode.wrappedValue.dismiss()
//        }
//    }) {
//        Image(systemName: "arrow.backward")
//            .resizable()
//            .modifier(Icon())
//            .frame(width: 25)
//    }
//    }
//    
//    var body: some View {
//        ZStack{
//            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea(.all)
//            
//            if showAddTracksToPlaylistView{
//                AddTracksToPlayListView(showView: $showAddTracksToPlaylistView)
//            }else{
//                
//                VStack(spacing: searchActive ? 0 :30){
//                    //MARK: - THUMBNAIL IMG
//                    Image(imgName)
//                        .resizable()
//                        .frame(width: searchActive ? 0 : UIScreen.main.bounds.width/1.5,height:searchActive ? 0 : UIScreen.main.bounds.width/1.6)
//                    
//                        .opacity(searchActive ? 0 : 1)
//                        .modifier(Img())
//                    
//                    HStack{
//                        VStack(alignment: .leading){
//                            //MARK: - PLAYLIST NAME
//                            Text(playlistName)
//                                .font(.custom("Gotham-Bold", size: 30))
//                                .modifier(OneLineText())
//                            Text("\(numOfTracks) track(s)")
//                                .font(.custom("Gotham-Me", size: 20))
//                                .modifier(OneLineText())
//                        }
//                        Spacer()
//                        //MARK: - PLAY BUTTON
//                        Button {
//                            playMusicAvtive.toggle()
//                        } label: {
//                            Image(systemName: playMusicAvtive ? "pause.circle.fill" : "play.circle.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 60, alignment: .center)
//                                .foregroundColor(.accentColor)
//                                .background(
//                                    Circle()
//                                        .fill(Color(.white))
//                                )
//                        }
//
//
//                    }
//                    .offset(y: searchActive ? -50 : 0)
//                    .frame(height: searchActive ? 0 : nil)
//                    .opacity(searchActive ? 0 : 1)
//                    
//                    //MARK: - LIST OF TRACKS
//                    List{
//                        
//                        //MARK: ADD TO PLAYLIST BUTTON
//                        Button{
//                            withAnimation {
//                                showAddTracksToPlaylistView = true
//                            }
//                            
//                        }label: {
//                            AddToPlaylistButtonView()
//                        }
//                        .listRowInsets(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        
//                        Button{
//                            
//                        }label: {
//                            MusicRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 23, subTitle: "Artists", subTitleSize: 17)
//                        }
//                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        
//                        Button{
//                            
//                        }label: {
//                            ListRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 23, subTitle: "Artists", subTitleSize: 17)
//                        }
//                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        
//                    }
//                    .listStyle(PlainListStyle())
//                    
//                    Spacer()
//                }
//                .modifier(PagePadding())
//                
//                .navigationBarTitleDisplayMode(.inline)
//                .navigationBarItems(leading: btnBack)
//                .toolbar{
//                    ToolbarItem(placement: .principal) {
//                        //MARK: - SEARCH BAR
//                        SearchBarView(searchInput: $searchInput, prompt: "Find in playlist")
//                            .onTapGesture {
//                                withAnimation {
//                                    searchActive = true
//                                }
//                            }
//                        
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        //MARK: SHOW MORE OPTIONS BUTTON
//                        Button {
//                            showPlaylistUpdateSheet = true
//                        } label: {
//                            Image(systemName: "ellipsis")
//                                .resizable()
//                                .modifier(Icon())
//                                .rotationEffect(.degrees(90))
//                        }
//                        .frame(width: searchActive ? 0 : nil)
//                        .opacity(searchActive ? 0 : 1)
//                        .disabled(searchActive)
//                        .animation(nil)
//                        .sheet(isPresented: $showPlaylistUpdateSheet) {
//                            PlaylistUpdateSheet(parentPresentationMode: presentationMode,showAddTracksToPlaylistView: $showAddTracksToPlaylistView, showEditPlaylistView: $showEditPlaylistView, imgName: imgName, playlistName: playlistName, numOfTracks: numOfTracks)
//                                .presentationDetents([.medium])
//                              
//                        }
//                        
//                    }
//                }
//                
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .fullScreenCover(isPresented: $showEditPlaylistView) {
//            EditPlaylistView()
//        }
//    }
//}
//
//struct AddToPlaylistButtonView: View {
//    var body: some View {
//        HStack(spacing: UIScreen.main.bounds.width/25) {
//            Image(systemName: "plus.square.fill")
//                .resizable()
//                .frame(width: 60, height: 60)
//                .modifier(Icon())
//                .foregroundColor(Color("black"))
//                .shadow(radius: 1)
//
//            Text("Add to this playlist")
//                .font(.custom("Gotham-Medium", size: 21))
//                .modifier(OneLineText())
//        }
//        .frame(width: .infinity)
//        .padding(.vertical, 10)
//        .padding(.horizontal)
//
//    }
//}
//
//struct PlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistView(imgName: .constant("testImg"), playlistName: .constant("Playlist Name"), numOfTracks: .constant(3))
//    }
//}
