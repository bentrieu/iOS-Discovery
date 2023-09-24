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

struct GenreView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var musicManager = MusicManager.instance
    let genre: String
    let color: Color
   
    var body: some View {
        ZStack{
            // Apply a linear gradient background with the provided color.
            LinearGradient(gradient: Gradient(colors: [color, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            ScrollView {
                VStack{
                    //MARK: - LIST OF TRACKS
                    VStack {
                        // Display a list of tracks from the musicManager.
                        ForEach(musicManager.musicList, id: \.musicId) { item in
                            Button {
                                // Play the selected track.
                                musicManager.currPlaying = item
                                musicManager.play()
                                   
                            } label: {
                                // Display a MusicRowView for each track.
                                MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: item)
                            }
                        }
                    }
                }
            }
//            .modifier(PagePadding())
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem (placement: .navigationBarLeading){
                Button {
                    // Dismiss the view when the back button is pressed.
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    BackButton()
                }
            }
            ToolbarItem (placement: .principal){
                //MARK: - GENRE NAME
                Text(genre)
                    .font(.custom("Gotham-Black", size: 30))
                    .modifier(BlackColor())
            }

        }
        
   
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(genre: "Hip-hop", color: .green)
    }
}
