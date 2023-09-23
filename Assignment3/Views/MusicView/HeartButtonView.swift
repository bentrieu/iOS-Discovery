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

struct HeartButtonView: View {
    @Binding var active: Bool
    var startAnimation: Bool
    var animationScale : CGFloat{
        active ? 1.3 : 0.7
    }
    
    var body: some View {
        Image(systemName: active ? "heart.fill" : "heart")
            .resizable()
            .scaledToFit()
            .foregroundColor(active ? .accentColor : Color("black"))
            .frame(height: 30)
            .scaleEffect(startAnimation ? animationScale : 1)
            .animation(.easeInOut(duration: 0.2), value: startAnimation)
    }
}


struct HeartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HeartButtonView(active: .constant(false), startAnimation: false)
    }
}
