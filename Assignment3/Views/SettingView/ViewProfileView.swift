//
//  ViewProfileView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct ViewProfileView: View {
    
    @State private var accountProfile = account
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
                        AccountProfileDetail(account: accountProfile)
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
                        EditProfileView(account: $accountProfile, isCancelButtonPressed: $isCancelButtonPressed, isContentNotEdited: $isContentNotEdited, isPresentingEdit: $isPresentingEdit)
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
            
//            EditProfileView(account: $accountProfile, isCancelButtonPressed: $isCancelButtonPressed,  isContentNotEdited: $isContentNotEdited,isPresentingEdit: $isPresentingEdit)
//                .position(x: UIScreen.main.bounds.width / 2 , y: isPresentingEdit ?  UIScreen.main.bounds.height / 2  : UIScreen.main.bounds.height * 2)
//                .zIndex(20)
            
            
        }
    }
}

struct ViewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfileView()
    }
}

struct AccountProfileDetail: View {
    var account: Account
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: account.imageURL)) { image in
                image.resizable()
            } placeholder: {
                
            }
            .scaledToFit()
            .frame(width:120, height: 120)
            .clipShape(Circle())
            
            Text(account.name)
                .font(Font.custom("Gotham-Bold", size: 22))
                .foregroundColor(Color("black"))
        }
        .offset(y:20)
        .padding(.horizontal)
    }
}
