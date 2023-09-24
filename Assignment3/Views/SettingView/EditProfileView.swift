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
import PhotosUI

struct EditProfileView: View {
    //    @Binding var account: Account
    @StateObject var userViewModel: UserViewModel
    
    //declare the temp variables just to be placeholder
    //once the user save edit we will overwrite to account variable
    @State var tempName: String  = ""
    @Binding var isCancelButtonPressed: Bool
    @Binding var isContentNotEdited: Bool
    @Binding  var isPresentingEdit : Bool
    @FocusState private var focusedField: Bool
    @State private var item: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var loading = true
    var callback: ()->Void
    var body: some View {
        ZStack {
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 15){
                //MARK: - HEADER VIEW
                HeadingControllerButtonView(userViewModel: userViewModel ,isContentNotEdited: $isContentNotEdited, isCancelButtonPressed: $isCancelButtonPressed, isPresentingEdit: $isPresentingEdit,tempName: $tempName, focusField: $focusedField){
                    if let item {
                        userViewModel.saveProfileImage(item: item)
                        callback()
                    }
                }
                if let selectedImage{
                    selectedImage
                        .resizable()
                        .modifier(AvatarView(size: 200))
                    let _ = print(selectedImage)
                }else {
                    AvatarViewContructor(size: 200, userViewModel: userViewModel){
                        loading = false
                    }
                }
                
                //MARK: - CHANGE PHOTO BUTTON
                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
                    Text("Change photo")
                }
                
                //MARK: - USER NAME
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
            
            if isCancelButtonPressed{
                if !isContentNotEdited{
                    //MARK: - CONFIRM NOTIFICATION
                    EditModalLeaveConfirmView(isPresentingEdit: $isPresentingEdit, isCancelButtonPressed: $isCancelButtonPressed, focusField: $focusedField)
                }
            }
            if loading{
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .ignoresSafeArea()
            }
        }
        .onChange(of: item, perform: { newValue in
            self.isContentNotEdited  = false
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                        return
                    }
                }
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
//
//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView(userViewModel: UserViewModel(), isCancelButtonPressed: .constant(false),  isContentNotEdited: .constant(true),isPresentingEdit: .constant(true), callback: {})
//    }
//}

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
//MARK: - HEADER IMPLEMENTATION
struct HeadingControllerButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var userViewModel: UserViewModel
    
    @Binding var isContentNotEdited: Bool
    @Binding var isCancelButtonPressed: Bool
    @Binding  var isPresentingEdit : Bool
    @Binding var tempName: String
    var focusField: FocusState<Bool>.Binding
    
    var callback : () -> Void
    
    var body: some View {
        HStack{
            //MARK: - CANCEL BUTTON
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
            
            //MARK: - HEADER
            Text("Edit Profile")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 14))
            
            Spacer()
            
            //MARK: - SAVE BUTTON
            Button {
                userViewModel.updateUserProfile(usernameText: tempName)
                callback()
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
