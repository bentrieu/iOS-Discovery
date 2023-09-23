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

struct PlaylistRowView: View {
    let imgDimens: CGFloat
    let titleSize: CGFloat
    let subTitleSize: CGFloat
    var playlist :  DBPlaylist
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/25){
            
            AsyncImage(url: URL(string: playlist.photoUrl!)) { phase in
                if let image = phase.image {
                    // if the image is valid
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    //appears as placeholder & error image
                    Image(systemName: "photo") 
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: imgDimens, height: imgDimens)
            .clipped()
            .overlay(
                Rectangle()
                    .stroke(.gray, lineWidth: 3)
            )

            VStack(spacing: 5){
                Text(playlist.name!)
                    .font(.custom("Gotham-Medium", size: titleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(playlist.musics!.count) tracks")
                    .font(.custom("Gotham-Book", size: subTitleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear{
            print(playlist.photoUrl!)
        }
        .frame(width: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

//struct ListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistRowView(imgDimens: <#CGFloat#>, titleSize: <#CGFloat#>, subTitleSize: <#CGFloat#>, music: <#Music#>)
//    }
//}
