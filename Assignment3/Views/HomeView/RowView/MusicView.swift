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

struct MusicView: View {
    @State var musics : [Music] = []
    @StateObject var musicManager = MusicManager.instance
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended Music")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(musics, id: \.musicId) { item in
                        Button {
                            //set the current music to the selected music
                            musicManager.currPlaying = item

                            //make sure the music list contain the selected music itself
                            musicManager.musicList.removeAll()
                            musicManager.musicList.append(item)

                            //play the music
                            musicManager.play()
                               
                        } label: {
                            VStack(alignment: .leading){
                                SquareView(imageUrl: item.imageUrl!, size: 110)
                                VStack(alignment: .leading, spacing: -5){
                                    Text(item.musicName!)
                                        .font(Font.custom("Gotham-Medium", size: 13))
                                        .lineLimit(1)
                                        .padding(.top,5)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                                .offset(y:-10)
                                .foregroundColor(Color("black"))
                                .frame(width: 110,alignment: .leading)
                            }
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .onAppear{
            Task {
                do {
                    self.musics = try await MusicViewModel.shared.getMusicListFromAlbum("fC5YS4zCnX0m6Ob8V17I")
                    // Handle the albums
                } catch {
                    // Handle any errors that occur during the asynchronous operation
                    print("Error: \(error)")
                }
            }
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}




