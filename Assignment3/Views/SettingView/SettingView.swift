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
import LocalAuthentication

struct SettingView: View {
    
    @StateObject var userViewModel: UserViewModel
    //    @StateObject var settingViewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var errorPopUp = false
    @State private var loading = true
    
    //    var account: Account
    var body: some View {
        ZStack {
            VStack{
                //MARK: - VIEW PROFILE BUTTON
                NavigationLink {
                    ViewProfileView(userViewModel: userViewModel)
                        .modifier(CustomNavigationButton())
                } label: {
                    AccountProfile(userViewModel: userViewModel){
                        loading = false
                    }
                    .modifier(CustomNavigationButton())
                    .padding(.bottom)
                }
                //MARK: - CHANGE THEME BUTTON
                NavigationLink {
                    ThemeEditingView(userViewModel: userViewModel)
                        .navigationTitle("Theme Setting")
                        .modifier(CustomNavigationButton())
                } label: {
                    SettingItemView(name: "Theme")
                        .modifier(CustomNavigationButton())
                }
                
                //MARK: - LOGOUT BUTTON
                Button {
                    Task {
                        do {
                            try userViewModel.signOut()
                            showSignInView = true
                            MusicManager.instance.isPlayingMusicView = false
                            MusicManager.instance.player?.pause()
                        } catch {
                            print("error: \(error)")
                        }
                    }
                } label: {
                    Text("Log out")
                        .foregroundColor(.black)
                        .font(Font.custom("Gotham-Bold", size: 16))
                        .tracking(-1)
                        .frame(width: 85, height: 20)
                        .padding()
                        .background(Color("gray").opacity(0.6))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                //MARK: - DELETE ACCOUNT BUTTON
                Button {
                    authenticate()
                    if SettingManager.shared.errorPopUp {
                        withAnimation() {
                            errorPopUp = true
                        }
                        print( SettingManager.shared.errorPopUp)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                errorPopUp = false
                                SettingManager.shared.errorPopUp = false
                            }
                        }
                    }else{
                        MusicManager.instance.isPlayingMusicView = false
                        MusicManager.instance.player?.pause()
                    }
                } label: {
                    Text("Delete account")
                        .foregroundColor(.black)
                        .font(Font.custom("Gotham-Bold", size: 16))
                        .tracking(-1)
                        .frame(width: 150, height: 20)
                        .padding()
                        .background(Color.red.opacity(0.6))
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .padding(.horizontal)
            
            //MARK: - LOADING VIEW
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
            
            //MARK: - ERROR VIEW
            ErrorView(errorMessage: SettingManager.shared.msg) // Error view for pre-filled cell error
                .position(x: UIScreen.main.bounds.width/2, y: self.errorPopUp ? 100 : -30) // Position error view
                .edgesIgnoringSafeArea(.top) // Ignore safe area edges
        }
    }
    
    //MARK: - AUTHENTICATE FUNCTION
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is to confirm delete account") { success, authenticationError in
                
                if success {
                    Task {
                        AuthenticationManager.instance.isAuthenticateExpired { isExpired, error in
                            if let error = error {
                                // Handle the error
                                print(error.localizedDescription)
                            } else if let isExpired = isExpired {
                                if isExpired {
                                    SettingManager.shared.msg = "Token expired, please sign out and login again"
                                    SettingManager.shared.errorPopUp = true
                                } else {
                                    Task {
                                        do {
                                            try await StorageManager.instance.deleteUserImage()
                                            print("deleted images!!!!!!")
                                            try await UserManager.instance.deteleCurrentUser()
                                            print("deleted document!!!!!!")
                                            try await AuthenticationManager.instance.deleteUser()
                                            print("deleted authentication!!!!!!")
                                            showSignInView = true
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("there was a problem")
                }
            }
        } else {
            SettingManager.shared.msg = "There is no Face ID"
            SettingManager.shared.errorPopUp = true
            print("there is no faceid")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingView(userViewModel: UserViewModel(), showSignInView: .constant(true))
    }
}

//MARK: - ACCOUNT PROFILE VIEW
struct AccountProfile: View {
    @StateObject var userViewModel: UserViewModel
    var callback: ()->Void
    var body: some View {
        HStack{
            AvatarViewContructor(size: 50, userViewModel: userViewModel){
                callback()
            }
            VStack(alignment: .leading){
                if let user = userViewModel.user {
                    if let name = user.displayName {
                        Text(name)
                            .font(Font.custom("Gotham-Meidum", size: 16))
                    }
                }
                Text("View Profile")
                    .font(Font.custom("Gotham-Meidum", size: 12))
                    .foregroundColor(Color("black").opacity(0.6))
            }
            .foregroundColor(Color("black"))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color("black"))
        }
        
    }
}

//MARK: - SETTING ITEM VIEW
struct SettingItemView: View {
    var name: String
    var body: some View {
        HStack{
            Text(name)
                .font(Font.custom("Gotham-Medium", size: 14))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color("black"))
        }
        .padding(.bottom)
    }
}
