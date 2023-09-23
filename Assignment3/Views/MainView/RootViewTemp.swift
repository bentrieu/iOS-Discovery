//
//  RootViewTemp.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var musicManager = MusicManager.instance
    @State private var expand = false
    @Binding var showSignInView: Bool
    @StateObject var albumListManager = AlbumListManager.shared
    @Namespace var animation
    @State private var loading = true
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            //MARK: TABVIEW
            TabView {
                HomeView(userViewModel: userViewModel, showSignInView: $showSignInView)
                    .tabItem {
                        Label("Home", systemImage:  "house.fill")
                            .foregroundColor(Color("black"))
                    }
                DiscoveryView()
                    .tabItem {
                        Label("Search", systemImage:  "magnifyingglass")
                            .foregroundColor(Color("black"))
                    }
                
                SearchView()
                    .tabItem {
                        VStack{
                            Label("Library", systemImage:  "books.vertical.fill")
                                .foregroundColor(Color("black"))
                        }
                       
                    }
            }
            //
            if musicManager.isPlayingMusicView{
                MiniPlayer(animation: animation, expand: $expand)
            }
            
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            Task {
                do {
                    try? await userViewModel.loadCurrentUser()
//                    try? await viewModel.loadUserPlaylist()
                } catch {
                    print(error)
                }
            }
            Task {
                albumListManager.popularAlbums = try await AlbumManager.shared.getAlbumCollectionByName("Popular Albums")
                loading = false
                
            }
            Task {
                albumListManager.chart = try await AlbumManager.shared.getAlbumCollectionByName("Charts")
               
            }
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(Color("black"))
    }
}

struct RootViewTemp_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSignInView: .constant(false))
    }
}
struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .frame(width: 50, height: 50)// This displays a spinning activity indicator
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
    }
}
