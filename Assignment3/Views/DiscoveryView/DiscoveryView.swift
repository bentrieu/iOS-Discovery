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
import UIKit



struct DiscoveryView: View {
    
    @StateObject var musicManager = MusicManager.instance
    @State var albumSearch = false
    @State var searchActive = false
    @State var searchInput = ""
    
    @State var showPlayMusicView = false
    
    var trackSearchResult : [Music]{
        return MusicViewModel.shared.searchMusicByNameAndArtist(input: searchInput)
    }
    var albumSearchResult : [Album]{
        return AlbumManager.shared.searchAlbumByNameAndArtist(input: searchInput)
    }
    
    private var gridItemLayout: [GridItem]{
        if UIDevice.current.userInterfaceIdiom == .phone {
            return [GridItem(.flexible()), GridItem(.flexible())]
        } else{
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        }
    }
    var body: some View {
        NavigationStack {
            ZStack{
                Color("white")
                NavigationView {
                    VStack{
                        
                        HStack{
                            //MARK: - HEADER
                            Text("Discovery")
                                .font(.custom("Gotham-Black", size: 40))
                                .modifier(BlackColor())
                            Spacer()
                        }
                        .frame(height: searchActive ? 0 : nil)
                        .opacity(searchActive ? 0 : 1)
                        .padding(.bottom, searchActive ? -5 : 5)
                        
                        
                        
                        HStack{
                            //MARK: - SEARCH BAR BUTTON
                            SearchBarView(searchInput: $searchInput, prompt: "Choose your music")
                                .onTapGesture {
                                    withAnimation {
                                        searchActive = true
                                    }
                                }
                            //MARK: - CANCEL SEARCH
                            Button{
                                searchInput = ""
                                withAnimation {
                                    searchActive = false
                                }
                                //remove focus on search bar when tap on other views
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                            }label: {
                                Text("Cancel")
                                    .font(.custom("Gotham-Medium", size: 18))
                                    .modifier(BlackColor())
                            }
                            .frame(width: searchActive ? nil : 0, height: searchActive ? nil : 0)
                            .opacity(searchActive ? 1 : 0)
                            .disabled(!searchActive)
                        }
                        
                        HStack{
                            Text("Browse all")
                                .font(.custom("Gotham-Medium", size: 20))
                                .modifier(BlackColor())
                            Spacer()
                        }
                        .padding(.top, searchActive ? 0 : 20)
                        .frame(height: searchActive ? 0 : nil)
                        .opacity(searchActive ? 0 : 1)
                        .offset(y: searchActive ? 30 : 0)
                        
                        //MARK: - GENRE LIST
                        LazyVGrid(columns: gridItemLayout){
                            ForEach(Genre.allCases, id: \.self){ genre in
                                NavigationLink {
                                    GenreView(genre: genre.rawValue, color: genre.color)
                                        .onAppear{
                                            musicManager.searchMusicByGenre(genre)
                                        }
                                } label: {
                                    GenreCardView(genre: genre.rawValue, color: genre.color)
                                    
                                }
                            }
                            
                        }
                        .frame(height: searchActive ? 0 : nil)
                        .opacity(searchActive ? 0 : 1)
                        .disabled(searchActive)
                        .offset(y: searchActive ? 100 : 0)
                        
                        //MARK: - SEARCH CATEGORIES
                        HStack{
                            //MARK: - TRACKS SEARCH CATEGORY
                            Button{
                                albumSearch = false
                            }label: {
                                Text("Tracks")
                                    .font(.custom("Gotham-Medium", size: albumSearch ? 17 : 19))
                                    .foregroundColor(albumSearch ? Color.gray : Color("black"))
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .fill(albumSearch ? Color("white"): Color.accentColor)
                                    )
                            }
                            //MARK: - TRACKS SEARCH CATEGORY
                            Button{
                                albumSearch = true
                            }label: {
                                Text("Albums")
                                    .font(.custom("Gotham-Medium", size: albumSearch ? 19 : 17))
                                    .foregroundColor(albumSearch ? Color("black") : Color.gray)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 20)
                                    .background(
                                        Capsule()
                                            .fill(albumSearch ? Color.accentColor : Color("white"))
                                    )
                            }
                            Spacer()
                        }
                        .frame(height: searchInput.isEmpty ? 0 : nil)
                        .opacity(searchInput.isEmpty ? 0 : 1)
                        .disabled(searchInput.isEmpty)
                        .padding(.bottom, searchInput.isEmpty ? 0 : 20)
                        //MARK: - SEARCH LIST
                        Group{
                            if albumSearch{
                                
                                //MARK: - ALBUMS TAB
                                LazyVGrid(columns: gridItemLayout){
                                    ForEach(albumSearchResult, id: \.albumId) {album in
                                        NavigationLink {
                                            AlbumPageView(album: album)
                                        } label: {
                                            VStack(alignment: .leading){
                                                SquareView(imageUrl: album.imageUrl!, size: 160)
                                                TextForAlbumView(title: album.title!, type: album.type!, name: album.artistName!, size: 160)
                                            }
                                        }
                                    }
                                }
                                .frame(height: albumSearchResult.isEmpty ? 0 : nil)
                            }else{
                                //MARK: - TRACKS TAB
                                List{
                                    ForEach(trackSearchResult, id: \.musicId) {music in
                                        Button{
                                            //set the current music to the selected music
                                            musicManager.currPlaying = music
                                            
                                            //make sure the music list contain the selected music itself
                                            musicManager.musicList.removeAll()
                                            musicManager.musicList.append(music)
                                            
                                            //play the music
                                            musicManager.play()
                                        }label: {
                                            MusicRowView(imgDimens: 60, titleSize: 23, subTitleSize: 20, music: music)
                                        }
                                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                                        .listRowBackground(Color.clear)
                                        .listRowSeparator(.hidden)
                                    }
                                    
                                }
                                .listStyle(PlainListStyle())
                                .frame(height: trackSearchResult.isEmpty ? 0 : nil)
                            }
                        }
                        .frame(height: searchInput.isEmpty ? 0 : nil)
                        .opacity(searchInput.isEmpty ? 0 : 1)
                        .disabled(searchInput.isEmpty)
                        
                        
                        if  searchInput.isEmpty{
                            Spacer()
                        }
                        
                        
                        //MARK: - SEARCH NOTIFICATION
                        Group{
                            Text(searchInput.isEmpty ? "Play what you love" : "Couldn't find '\(searchInput)'")
                                .font(.custom("Gotham-Black", size: 22))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                            Text(searchInput.isEmpty ? "Search tracks, albums by name or artists" : "Trying searching again using a different spelling or keyword")
                                .font(.custom("Gotham-Medium", size: 16))
                                .modifier(BlackColor())
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: searchActive && (searchInput.isEmpty || (albumSearch ? albumSearchResult.isEmpty : trackSearchResult.isEmpty)) ? nil : 0)
                        .opacity(searchActive && (searchInput.isEmpty || (albumSearch ? albumSearchResult.isEmpty : trackSearchResult.isEmpty)) ? 1 : 0)
                        
                        Spacer()
                    }.modifier(PagePadding())
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
            .task {
                do {
                    AlbumManager.shared.albums = try await AlbumManager.shared.getAlbumCollectionByName("Popular Albums")
                    // Handle the albums
                } catch {
                    // Handle any errors that occur during the asynchronous operation
                    print("Error: \(error)")
                }
            }
        }
        .onDisappear {
            searchInput = ""
            searchActive = false
        }
    }
}

struct GenreCardView: View{
    let genre: String
    let color: Color
    private var width: CGFloat{
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 170
        } else{
            return 210
        }
    }
    private var height: CGFloat{
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 100
        } else{
            return 130
        }
    }
    
    var body: some View{
        ZStack{
            color
            Text(genre)
                .font(.custom("Gotham-Black", size: 20))
                .modifier(BlackColor())
        }
        .cornerRadius(15)
        .frame(width: width, height: height)
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
