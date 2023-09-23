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

struct ChangePhotoView: View {
    @State private var imageURL: String = ""
    @State private var onEditing = false
    @Binding var isPresentingEditPicture : Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Image URL")
                    .foregroundColor(Color("black"))
                    .font(Font.custom("Gotham-Bold", size: 16))
                TextField("Enter URL", text: $imageURL,onEditingChanged: { edit in
                    self.onEditing = edit
                    
                })
                .padding(.horizontal)
                .textFieldStyle(CustomTextFieldStyle(focus: $onEditing))
                
                
                HStack{
                    Button {
                        withAnimation {
                           isPresentingEditPicture = false
                        }
                    } label: {
                        Text("Cancel")
                            .modifier(CustomeButtonEditPictureView())
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("black"))
                            }
                    }
                    
                    
                    Button {
                        withAnimation {
                           isPresentingEditPicture = false
                        }
                    } label: {
                        Text("Save")
                            .modifier(CustomeButtonEditPictureView())
                            .background(Color("green"))
                            .clipShape(Capsule())
                    }
                }
                .padding(.top)
            }
            .frame(width: 300,height: 250)
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("white"))
            }
            
          
        }
        .foregroundColor(Color("black"))
       
    }
}

struct ChangePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePhotoView(isPresentingEditPicture: .constant(true))
    }
}
