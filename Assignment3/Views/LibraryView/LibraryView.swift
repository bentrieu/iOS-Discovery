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
import PhotosUI
struct LibraryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var playlistManager = PlaylistManager.instance
    @StateObject private var userViewModel = UserViewModel()
    @State var showAddNewPlaylistView = false
    @State var searchActive = false
    @State var searchInput = ""
    @State var loading = true
    var playlistSearchResult : [DBPlaylist]{
    
        return searchInput.isEmpty ? playlistManager.playlists : playlistManager.searchPlaylistByName(input: searchInput)
    }
    
    
    var body: some View {
        ZStack{
            Color("white")
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack{
                        HStack(spacing:20){
                            //MARK: - BACK BTN WHEN SEARCHING
                            Button {
                                withAnimation {
                                    searchActive = false
                                }
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .resizable()
                                    .modifier(Icon())
                                    .frame(width: 25)
                            }
                            //MARK: - SEARCH BAR
                            FocusedSearchBarView(searchInput: $searchInput,searchActive: $searchActive, prompt: "Find playlist")
                            
                        }
                        .opacity(searchActive ? 1 : 0)
                        .frame(height: searchActive ? nil : 0)
                        .offset(y: searchActive ? 0 : 80)
                        .disabled(!searchActive)
                    
                    
                    //MARK: - HEADER
                    HStack{
                        //MARK: - USER PROFILE BUTTON
//                        Button {
//                            self.presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image("testImg")
//                                .resizable()
//                                .frame(width: 45, height: 45)
//                                .modifier(Img())
//                                .clipShape(Circle())
//                        }

                        AvatarViewContructor(size: 50, userViewModel: userViewModel) {
                            loading = false
                        }
                        
                        
                        Text("Your Library")
                            .font(.custom("Gotham-Black", size: 30))
                            .modifier(BlackColor())
                        Spacer()
                        
                        //MARK: - SEARCH BUTTON
                        Button {
                            withAnimation {
                                searchActive = true
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 28)
                                .foregroundColor(Color("black"))
                        }
                        
                        //MARK: - ADD NEW PLAYLIST BUTTON
                        Button {
                            showAddNewPlaylistView = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 28)
                                .foregroundColor(Color("black"))
                        }.fullScreenCover(isPresented: $showAddNewPlaylistView) {
                            //MARK: ADD NEW PLAYLIST VIEW
                            ZStack{
                                LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                                    .ignoresSafeArea(.all)
                                NewPlaylistView(showView: .constant(false))
                                    .modifier(PagePadding())
                            }
                            
                        }
                    }
                    .padding(.bottom, searchActive ? 0 : 40)
                    .opacity(searchActive ? 0 : 1)
                    .frame(height: searchActive ? 0 : nil)
                    .offset(y: searchActive ? -80 : 0)
                    .disabled(searchActive)
                    
                    
                    Divider()
                        .frame(height: searchActive ? 0 : 1)
                        .overlay(Color("black"))
                        .padding(.bottom, searchActive ? 0 : 40)
                        .opacity(searchActive ? 0 : 1)
                        .disabled(searchActive)
                    
                    if !playlistManager.playlists.isEmpty{
                        if playlistSearchResult.isEmpty{
                            //MARK: - SEARCH NOTIFICATION
                            Text("No results found for '\(searchInput)'")
                                .font(.custom("Gotham-Black", size: 22))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                            Text("Check the spelling, or try different keywords.")
                                .font(.custom("Gotham-Medium", size: 17))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                            Spacer()
                        }else{
                            //MARK: - LIST OF PLAYLIST
                            List{
                                ForEach(playlistSearchResult, id: \.playlistId) {playlist in
                                    NavigationLink (destination: PlaylistView(playlist: playlist)
                                        .onAppear {
                                            searchActive = false
                                        }){
                                            PlaylistRowView(imgDimens: 60, titleSize: 23, subTitleSize: 18, playlist: playlist)
                                            
                                        }
                                        .listRowInsets(.init(top: -5, leading: 0, bottom: 10, trailing: 0))
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                }
                                //MARK: - DELETE PLAYLIST ITEM FUNCTION
                                .onDelete { offsets in
                                    Task{
                                        for index in offsets{
                                            //delete playlist on firestore
                                            do{
                                                try await playlistManager.removePlaylist(playlistId: playlistSearchResult[index].playlistId)
                                            }catch{
                                                print(error)
                                            }
                                            //fetch change to local playlists array
                                            do{
                                                playlistManager.playlists = try await playlistManager.getAllPlaylist()
                                            }catch{
                                                print(error)
                                            }
                                        }
                                    }
                                }
                            }.listStyle(PlainListStyle())
                        }
                    }else{
                        //MARK: NOTIFICATION WHEN NO PLAYLIST
                        Text("There is no playlist, please add one.")
                            .font(.custom("Gotham-BookItalic", size: 21))
                            .modifier(BlackColor())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .modifier(PagePadding())
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
            
        }
        .task {
            do{
                playlistManager.playlists = try await playlistManager.getAllPlaylist()
            } catch {
                // Handle the error
                print("Error: \(error)")
                
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
