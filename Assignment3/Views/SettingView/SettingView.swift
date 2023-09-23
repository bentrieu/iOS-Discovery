//
//  SettingView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var userViewModel: UserViewModel

//    var account: Account
    var body: some View {
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
            
//            ButtonTextField(title: "Log out")
           
    
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
       
            SettingView(userViewModel: UserViewModel())
    }
}

//struct Account{
//    var name: String
//    var username: String
//    var email: String
//    var password: String
//    var imageURL: String
//
//}
//let account = Account(name: "Hữu Phước", username: "phuoc05", email: "phuocdinh21102@gmail.com", password: "huuphuochahahjhj", imageURL: "https://scontent.fsgn2-3.fna.fbcdn.net/v/t39.30808-6/345072827_1301949700393436_9075755003333917361_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=TVqUyJ5J1OAAX_1TePk&_nc_ht=scontent.fsgn2-3.fna&oh=00_AfDu5bi68KQZDgeXxZqAgCI-Lzx7cXZIcwaqqR7Eo_T11w&oe=650DD836")

struct AccountProfile: View {
    
//    var account: Account
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        HStack{
            if let urlString = userViewModel.user?.profileImagePath, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    
                }
                .scaledToFit()
                .frame(width:50, height: 50)
                .clipShape(Circle())
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
