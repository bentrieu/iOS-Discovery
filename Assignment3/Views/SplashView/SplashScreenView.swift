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

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var showSignInView: Bool = false

    var body: some View {
        if isActive{
            if !showSignInView {
                MainView(showSignInView: $showSignInView)
            } else {
                LandingPageView(showSignInView: $showSignInView)
            }
        }else{
            ZStack {
                Color(SettingManager.shared.isDark ? .black : .white)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("icon-green")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            .onAppear{
                let authUser = try? AuthenticationManager.instance.getAuthenticatedUser()
                self.showSignInView = authUser == nil
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
          
    }
}
