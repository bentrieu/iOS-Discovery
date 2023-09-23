//
//  SettingView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI
import LocalAuthentication

struct SettingView: View {
    
    @StateObject var userViewModel: UserViewModel
    @StateObject var settingViewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var errorPopUp = false

//    var account: Account
    var body: some View {
        ZStack {
            VStack{
                NavigationLink {
                    ViewProfileView(userViewModel: userViewModel)
                        .modifier(CustomNavigationButton())
                } label: {
                    AccountProfile(userViewModel: userViewModel)
                        .modifier(CustomNavigationButton())
                        .padding(.bottom)
                }
                
                NavigationLink {
                    ThemeEditingView()
                        .navigationTitle("Theme Setting")
                        .modifier(CustomNavigationButton())
                } label: {
                    SettingItemView(name: "Theme")
                        .modifier(CustomNavigationButton())
                }
               
                Button {
                    Task {
                        do {
                            try settingViewModel.signOut()
                            showSignInView = true
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
            }
            .padding(.horizontal)
            
            ErrorView(errorMessage: "There is no Face ID") // Error view for pre-filled cell error
                .position(x: UIScreen.main.bounds.width/2, y: self.errorPopUp ? 100 : -30) // Position error view
                .edgesIgnoringSafeArea(.top) // Ignore safe area edges
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is to confirm delete account") { success, authenticationError in
                
                if success {
                    Task {
                        do {
                            try await StorageManager.instance.deleteUserImage()
                            try await UserManager.instance.deteleCurrentUser()
                            try await AuthenticationManager.instance.deleteUser()
                            showSignInView = true
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } else {
                    print("there was a problem")
                }
            }
        } else {
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
struct AccountProfile: View {
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        HStack{
            if let urlString = userViewModel.user?.profileImagePath, let url = URL(string: urlString) {
                AsyncImage(url: url){ image in
                    image.resizable()
                    
                }placeholder: {
                    
                }
                .modifier(AvatarView(size: 50))
            }else{
                AsyncImage(url: URL(string: "https://i.scdn.co/image/ab6761610000e5eb58efbed422ab46484466822b")){ image in
                    image.resizable()
                }placeholder: {
                    
                }
                .modifier(AvatarView(size: 50))
                
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
