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

struct QueueVIew: View {
    @StateObject private var musicManager = MusicManager.instance
    var body: some View {
        VStack(alignment: .leading){
            Text("Now Playing")
                .font(.custom("Gotham-Bold", size: 25))
                .modifier(BlackColor())
            //MARK: - CURRENT TRACK
            Button {
                
            } label: {
                Text("")
                MusicRowView(imgDimens: 60,  titleSize: 21,subTitleSize: 17, music: musicManager.currPlaying)
                
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.4)).shadow(radius: 1))
            }
            Text("Up Next")
                .font(.custom("Gotham-Bold", size: 25))
                .modifier(BlackColor())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: - TRACK LIST
            List{
                Button{
                    
                }label: {
                    MusicRowView(imgDimens: 60,  titleSize: 21,subTitleSize: 17, music: musicManager.currPlaying)
                    Text("")
                }
                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Button{
                    
                }label: {
                    Text("")
                    MusicRowView(imgDimens: 60,  titleSize: 21,subTitleSize: 17, music: musicManager.currPlaying)
                }
                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            .frame(height: UIScreen.main.bounds.height/2.2)
            Spacer()
        }
        .frame(width: .infinity)
        .padding(.top, 15)
    }
}

struct QueueVIew_Previews: PreviewProvider {
    static var previews: some View {
        QueueVIew()
    }
}
