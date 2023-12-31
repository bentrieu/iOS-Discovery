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

struct ThemeEditingView: View {
    @StateObject var userViewModel : UserViewModel
    @StateObject var settingManager = SettingManager.shared
    var body: some View {
        VStack{
            //MARK: - THEME TOGGLE VIEW
            Toggle(!SettingManager.shared.isDark ? "Light Theme" : "Dark Theme", isOn: $settingManager.isDark)
                .padding(.all)
            Spacer()
        }
        .onAppear{
            SettingManager.shared.isDark = userViewModel.user!.isDark!
        }
        .onChange(of: SettingManager.shared.isDark) { newValue in
            userViewModel.updateUserTheme(isDark: SettingManager.shared.isDark)
            Task{
                try await userViewModel.loadCurrentUser()
            }
        }
        
    }
}

struct ThemeEditingView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditingView(userViewModel: UserViewModel())
    }
}
