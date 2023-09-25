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
    
    //delcare all the all required varaibles for the views
    @StateObject var userViewModel = UserViewModel()
    @StateObject var musicManager = MusicManager.instance
    @StateObject var albumListManager = AlbumListManager.shared
    @State private var loading = true
    @State private var expand = false
    @Binding var showSignInView: Bool
    @Namespace var animation
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            //MARK: TABVIEW
            TabView {
                
                //MARK: HOMEVIEW
                HomeView(userViewModel: userViewModel, showSignInView: $showSignInView)
                    .tabItem {
                        Label("Home", systemImage:  "house.fill")
                            .foregroundColor(Color("black"))
                    }
                
                //MARK: DISCOVERY VIEW
                DiscoveryView()
                    .tabItem {
                        Label("Search", systemImage:  "magnifyingglass")
                            .foregroundColor(Color("black"))
                    }
                
                //MARK: LIBRARY VIEW
                LibraryView(userViewModel: userViewModel)
                    .tabItem {
                        VStack{
                            Label("Library", systemImage:  "books.vertical.fill")
                                .foregroundColor(Color("black"))
                        }
                        
                    }
            }
            
            //display MiniPlayer view if the user plays song
            if musicManager.isPlayingMusicView{
                MiniPlayer(expand: $expand, animation: animation)
            }
            
            //display loading modal waiting for the data fetch
            //completely
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            
            //load the current when access the app
            Task {
                do {
                    try? await userViewModel.loadCurrentUser()
                    if let user = userViewModel.user {
                        SettingManager.shared.isDark = user.isDark!
                    } else {
                        try await userViewModel.signOut()
                        showSignInView = true
                    }
                }
            }
            
            // load the popular album collection
            Task {
                albumListManager.popularAlbums = try await AlbumManager.shared.getAlbumCollectionByName("Popular Albums")
                loading = false
                
            }
            
            // load chart collection
            Task {
                albumListManager.chart = try await AlbumManager.shared.getAlbumCollectionByName("Charts")
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(Color("black"))
        .preferredColorScheme(
            //            userViewModel.user ?? userViewModel.user?.isDark ?? .light
            !SettingManager.shared.isDark ? .light : .dark
        )
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
        .background(Color("white").opacity(0.8))
        .cornerRadius(10)
    }
}
