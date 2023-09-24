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

struct HomeView: View {
    
    @StateObject var userViewModel: UserViewModel
    @StateObject var albumListManager = AlbumListManager.shared
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("white")
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack (alignment: .leading,spacing: 10){
                        HeadingView(userViewModel: userViewModel, showSignInView: $showSignInView)
                        
                        HStack{
                            
                            NavigationLink {
                                GenreView(genre: "All Musics", color: Color("white"))
                                    .onAppear{
                                        MusicManager.instance.musicList = MusicViewModel.shared.musics
                                    }
                            } label: {
                                CustomButton(name: "Music")
                            }
                        }
                        .padding()
                        
                        //MARK: RECOMMENDED MUSIC ROW VIEW
                        
                        MusicView()
                        
                        //MARK: ALBUM MUSIC ROW VIEW
                        if let _ = albumListManager.popularAlbums{
                            AlbumView()
                        }
                        
                        //MARK: CHART MUSIC ROW VIEW
                        if let _ =  albumListManager.chart{
                            ChartView()
                        }
                    }
                }
               
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userViewModel: UserViewModel(), showSignInView: .constant(false))
    }
}

struct HeadingView: View {
    
    @StateObject var userViewModel: UserViewModel
    @Binding var showSignInView: Bool
    @State private var greeting = "Good Morning"
    var body: some View {
        HStack(spacing: 15){
            Text(greeting)
                .tracking(-1)
                .font(Font.custom("Gotham-Bold", size: 26))
            Spacer()
                        
            NavigationLink {
                SettingView(userViewModel: userViewModel, showSignInView: $showSignInView)
                    .navigationTitle("Settings")
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("black"))
                    .frame(width: 24,height: 24 )
                    .bold()
                    
            }
        }
        .onAppear {
            updateGreeting()
            let timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                updateGreeting()
            }
            RunLoop.main.add(timer, forMode: .common)
        }
        .padding(.horizontal)
    }
    private func updateGreeting() {
            let currentTime = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: currentTime)
            
            if hour >= 12 {
                greeting = "Good Afternoon"
            } else {
                greeting = "Good Morning"
            }
        }
}



struct CustomButton: View {
    var name : String
    var body: some View {
        Text(name)
            .font(Font.custom("Gotham-Medium", size: 16))
            .foregroundColor(Color("black"))
            .padding(.horizontal)
            .padding(.vertical,5)
            .background(Color("gray").opacity(0.4))
            .clipShape(Capsule())
    }
}
