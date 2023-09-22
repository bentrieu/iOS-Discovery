//
//  EditProfileView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
//    @Binding var account: Account
    @ObservedObject var userViewModel: UserViewModel
    
    //declare the temp variables just to be placeholder
    //once the user save edit we will overwrite to account variable
    @State var tempName: String  = ""
//    @State var isPresentingEditPicture = false
    @Binding var isCancelButtonPressed: Bool
    @Binding var isContentNotEdited: Bool
    @Binding  var isPresentingEdit : Bool
    @FocusState private var focusedField: Bool
    
    @State private var item: PhotosPickerItem? = nil

    
    var body: some View {
        ZStack {
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 15){
                HeadingControllerButtonView(userViewModel: userViewModel ,isContentNotEdited: $isContentNotEdited, isCancelButtonPressed: $isCancelButtonPressed, isPresentingEdit: $isPresentingEdit,tempName: $tempName, focusField: $focusedField)
                
                
                if let urlString = userViewModel.user?.profileImagePath, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        
                    }
                    .scaledToFit()
                    .frame(width:180, height: 180)
                    .clipShape(Circle())
                    .frame(height: 200)
                }
                
                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
                    Text("Change photo")
                }
                if let user = userViewModel.user {
                    Text(user.userId)
                }
//                Button {
//                    isPresentingEditPicture = true
//                    isContentNotEdited = false
//                } label: {
//                    Text("Change photo")
//                        .foregroundColor(Color("black"))
//                        .font(Font.custom("Gotham-Bold", size: 12))
//                        .focused($focusedField)
//                }
                
                TextField("", text: Binding<String>(
                    get: { self.tempName },
                    set: { self.tempName = $0
                        self.isContentNotEdited = false
                       }
                     ))
                    .textFieldStyle(CustomTextFieldForEditView())
                    .padding(.horizontal,30)
                    .focused($focusedField)
                
                
                Text("This could be your first name or nickname. It's how you'll appear on Spotify.")
                    .foregroundColor(Color("black").opacity(0.6))
                    .font(Font.custom("Gotham-Medium", size: 12))
                    .multilineTextAlignment(.center)
                    .frame(width: 275)
                
                Spacer()
                
              
            }
//            if (isPresentingEditPicture){
//                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
//                    Text("select an image")
//                }
//            }
            
            if isCancelButtonPressed{
                if !isContentNotEdited{
                    EditModalLeaveConfirmView(isPresentingEdit: $isPresentingEdit, isCancelButtonPressed: $isCancelButtonPressed, focusField: $focusedField)
                }
            }
        }
        .onChange(of: item, perform: { newValue in
            if let newValue {
                userViewModel.saveProfileImage(item: newValue)
            }
        })
        .onAppear{
            if let user = userViewModel.user {
                if let name = user.displayName {
                    self.tempName = name
                }
            }
            self.isContentNotEdited = true
        }
       
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(userViewModel: UserViewModel(), isCancelButtonPressed: .constant(false),  isContentNotEdited: .constant(true),isPresentingEdit: .constant(true))
    }
}

struct CustomTextFieldForEditView: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.custom("Gotham-bold", size: 32))
            .tint(Color("green"))
            .multilineTextAlignment(TextAlignment.center)
            .overlay(alignment: .bottom) {
                Divider()
                    .background(Color("black").opacity(0.7))
            }
            
    }
}

struct HeadingControllerButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userViewModel: UserViewModel

    @Binding var isContentNotEdited: Bool
    @Binding var isCancelButtonPressed: Bool
    @Binding  var isPresentingEdit : Bool
    @Binding var tempName: String
    var focusField: FocusState<Bool>.Binding
    
    var body: some View {
        HStack{
            Button {
                withAnimation {
                    isCancelButtonPressed = true
                   
                }
               
                if isContentNotEdited{
                    withAnimation {
                        isPresentingEdit = false
                        focusField.wrappedValue = false
                    }
                }
                
            } label: {
                Text("Cancel")
                    .foregroundColor(Color("black"))
                    .font(Font.custom("Gotham-Medium", size: 12))
            }
            
            Spacer()
            
            Text("Edit Profile")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 14))
            
            Spacer()
            
            Button {
                userViewModel.updateUserProfile(usernameText: tempName)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .foregroundColor(isContentNotEdited ? Color("black").opacity(0.6) : Color("black"))
                    .font(Font.custom("Gotham-Medium", size: 12))
            }
            .disabled(isContentNotEdited)
            
            
            
        }
        .padding(.all)
        .padding(.bottom)
    }
}
