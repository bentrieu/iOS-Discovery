//
//  ViewProfileView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct ViewProfileView: View {
    
    @StateObject var userViewModel: UserViewModel

    @State private var isPresentingEdit = false
    @State var isCancelButtonPressed = false
    @State var isContentNotEdited = true
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading){
                LinearGradient(colors: [Color("black"),Color("grey")], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height:  150)
                    .overlay(alignment: .bottomLeading) {
                        AccountProfileDetail(userViewModel: userViewModel)
                    }
                    .padding(.bottom,30)
                
                HStack{
                    Button {
                        isCancelButtonPressed = false
                        isContentNotEdited = true
                        withAnimation {
                            
                            isPresentingEdit = true
                        }
                    } label: {
                        Text("Edit")
                            .font(Font.custom("Gotham-bold", size: 12))
                            .foregroundColor(Color("black"))
                            .frame(width: 50, height: 30)
                            .background{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("black"))
                            }
                    }.sheet(isPresented: $isPresentingEdit) {
                        EditProfileView(userViewModel: userViewModel, isCancelButtonPressed: $isCancelButtonPressed, isContentNotEdited: $isContentNotEdited, isPresentingEdit: $isPresentingEdit)
                    }
                }
                .padding(.all)
             
                VStack{
                    Text("Playlists")
                        .font(Font.custom("Gotham-bold", size: 16))
                        .foregroundColor(Color("black"))

                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct ViewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfileView(userViewModel: UserViewModel())
    }
}

struct AccountProfileDetail: View {
    
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        HStack {
            AvatarViewContructor(size: 140, userViewModel: userViewModel)
            
            if let user = userViewModel.user, let name = user.displayName {
                Text(name)
                    .font(Font.custom("Gotham-Bold", size: 22))
                    .foregroundColor(Color("black"))
            }
        }
        .offset(y:20)
        .padding(.horizontal)
    }
}


struct AvatarViewContructor: View {
    var size : CGFloat
    @ObservedObject var userViewModel: UserViewModel

    var body: some View {
        HStack {
            if let urlString = userViewModel.user?.profileImagePath, let url = URL(string: urlString) {
                AsyncImage(url: url){ image in
                    image.resizable()
                    
                }placeholder: {
                    
                }
                .modifier(AvatarView(size: size))
            }else{
                AsyncImage(url: URL(string: "https://i.scdn.co/image/ab6761610000e5eb58efbed422ab46484466822b")){ image in
                    image.resizable()
                }placeholder: {
                    
                }
                .modifier(AvatarView(size: size))
                
            }
            
        }
    }
}

