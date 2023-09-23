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

struct SquareView: View {
    var imageUrl : String
    var size : CGFloat
    var body: some View {
        
        VStack(spacing: 10){
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                
            }
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()

            
        }
        
    }
}

struct SquareView_Provider: PreviewProvider {
    static var previews: some View {
        SquareView(imageUrl: "https://i.scdn.co/image/ab67616d0000b273b315e8bb7ef5e57e9a25bb0f", size: 175)
    }
}

