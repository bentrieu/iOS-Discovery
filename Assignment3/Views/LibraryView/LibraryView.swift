////
////  LibraryView.swift
////  Assignment3
////
////  Created by DuyNguyen on 14/09/2023.
////
//
//import SwiftUI
//
//struct LibraryView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State var showAddNewPlaylistView = false
//    @State var searchActive = false
//    @State var searchInput = ""
//    
//    var body: some View {
//        ZStack{
//            Color("white")
//                .edgesIgnoringSafeArea(.all)
//            NavigationView {
//                VStack{
//                    //MARK: - SEARCH BAR + BACK BUTTON
//                    
//                        HStack(spacing:20){
//                            Button {
//                                
//                                withAnimation {
//                                    searchActive = false
//                                }
//                            } label: {
//                                Image(systemName: "arrow.backward")
//                                    .resizable()
//                                    .modifier(Icon())
//                                    .frame(width: 25)
//                            }
//                            
//                            FocusedSearchBarView(searchInput: $searchInput,searchActive: $searchActive, prompt: "Find playlist")
//                            
//                        }
//                        .opacity(searchActive ? 1 : 0)
//                        .frame(height: searchActive ? nil : 0)
//                        .offset(y: searchActive ? 0 : 80)
//                        .disabled(!searchActive)
//                    
//                    
//                    //MARK: - HEADER
//                    HStack{
//                        //MARK: - USER PROFILE BUTTON
//                        Button {
//                            self.presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image("testImg")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(Img())
//                                .clipShape(Circle())
//                        }
//
//
//                        
//                        
//                        Text("Your Library")
//                            .font(.custom("Gotham-Black", size: 30))
//                            .modifier(BlackColor())
//                        Spacer()
//                        
//                        //MARK: - SEARCH BUTTON
//                        Button {
//                            withAnimation {
//                                searchActive = true
//                            }
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                                .resizable()
//                                .modifier(Icon())
//                                .frame(width: 28)
//                                .foregroundColor(Color("black"))
//                        }
//                        
//                        //MARK: - ADD NEW PLAYLIST BUTTON
//                        Button {
//                            showAddNewPlaylistView = true
//                        } label: {
//                            Image(systemName: "plus")
//                                .resizable()
//                                .modifier(Icon())
//                                .frame(width: 28)
//                                .foregroundColor(Color("black"))
//                        }.fullScreenCover(isPresented: $showAddNewPlaylistView) {
//                            //MARK: ADD NEW PLAYLIST VIEW
//                            ZStack{
//                                LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
//                                    .ignoresSafeArea(.all)
//                                NewPlaylistView(showView: $showAddNewPlaylistView)
//                                    .modifier(PagePadding())
//                            }
//                            
//                        }
//                    }
//                    .padding(.bottom, searchActive ? 0 : 40)
//                    .opacity(searchActive ? 0 : 1)
//                    .frame(height: searchActive ? 0 : nil)
//                    .offset(y: searchActive ? -80 : 0)
//                    .disabled(searchActive)
//                    
//                    
//                    Divider()
//                        .overlay(Color("black"))
//                        .padding(.bottom, searchActive ? 0 : 40)
//                        .opacity(searchActive ? 0 : 1)
//                        .frame(height: searchActive ? 0 : nil)
//                        .disabled(searchActive)
//                    
//                    
//                    //MARK: - LIST OF PLAYLIST
//                    
//                    List{
//                        NavigationLink (destination: PlaylistView(imgName: .constant("testImg"), playlistName: .constant("Playlist Name"), numOfTracks: .constant(4))){
//                            ListRowView(imgName: "testImg", imgDimens: 60, title: "Playlist Name", titleSize: 23, subTitle: "Num of Tracks", subTitleSize: 17)
//                        }                    .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
//                            .listRowBackground(Color.clear)
//                            .listRowSeparator(.hidden)
//                        
//                    }.listStyle(PlainListStyle())
//                }
//                .modifier(PagePadding())
//                
//            }
//            .navigationViewStyle(StackNavigationViewStyle())
//            
//        }
//    }
//}
//
//struct LibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        LibraryView()
//    }
//}
