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
