//
//  ChangePhotoView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 18/09/2023.
//

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
