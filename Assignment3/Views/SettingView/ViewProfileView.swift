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

struct ViewProfileView: View {
    
    @StateObject var userViewModel: UserViewModel

    @State private var isPresentingEdit = false
    @State var isCancelButtonPressed = false
    @State var isContentNotEdited = true
    @State private var loading = true
    @State var id = UUID()
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading){
                LinearGradient(colors: [Color("black"),Color("grey")], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height:  150)
                    .overlay(alignment: .bottomLeading) {
                        AccountProfileDetail(userViewModel: userViewModel){
                            //remove loading modal when successfully
                            //display image
                            loading = false
                            print("close loading for ViewProfileView ")
                        }
                        .id(id)
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
                        EditProfileView(userViewModel: userViewModel, isCancelButtonPressed: $isCancelButtonPressed, isContentNotEdited: $isContentNotEdited, isPresentingEdit: $isPresentingEdit){
                            loading = true
                            self.id = UUID()
                        }
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
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
        }
        .onAppear{
            print(userViewModel.user)
        }
    }
}

struct ViewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfileView(userViewModel: UserViewModel())
    }
}

struct AccountProfileDetail: View {
    
    @StateObject var userViewModel: UserViewModel
    var callback : ()->Void
    var body: some View {
        HStack {
            AvatarViewContructor(size: 140, userViewModel: userViewModel){
                callback()
            }
            
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
    @StateObject var userViewModel: UserViewModel
    var callback: () -> Void
    var body: some View {
        HStack {
            if let urlString = userViewModel.user?.profileImagePath, let url = URL(string: urlString) {
                AsyncImage(url: url){ phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .modifier(AvatarView(size: size))
                            .onAppear{
                                callback()
                            }
                    }
                }
            }else{
                AsyncImage(url: URL(string: "https://i.scdn.co/image/ab6761610000e5eb58efbed422ab46484466822b")){ phase in
                    if let image = phase.image{
                       
                        image
                            .resizable()
                            .modifier(AvatarView(size: size))
                            .onAppear{
                                callback()
                            }
                    }
                }
            }
            
        }
    }
}

