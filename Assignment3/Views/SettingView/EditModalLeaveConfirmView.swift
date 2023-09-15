//
//  EditModalLeaveConfirmView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct EditModalLeaveConfirmView: View {
    @Binding  var isPresentingEdit : Bool
    @Binding var isCancelButtonPressed: Bool
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                
                Text("Discard changes?")
                    .font(Font.custom("Gotham-Medium", size: 16))
                
                Text("If you go back now, you'll lose your changes.")
                    .font(Font.custom("Gotham-Book", size: 12))
                    .frame(width: 270)
                
                
                Button {
                    withAnimation {
                        isCancelButtonPressed = false
                    }
                } label: {
                    Text("Keep editing")
                        .font(Font.custom("Gotham-Medium", size: 14))
                        .frame( height: 45)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(Color("green"))
                        .clipShape(Capsule())
                }
                
              
                
                Button {
                    withAnimation {
                        isPresentingEdit = false
                       
                    }
                } label: {
                    Text("Discard")
                        .font(Font.custom("Gotham-Medium", size: 14))
                }
            }
            .frame(width: 300, height: 200)
            .foregroundColor(.black)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                
            }
                
           
        }
      
        
            
    }
}

struct EditModalLeaveConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        EditModalLeaveConfirmView(isPresentingEdit: .constant(true), isCancelButtonPressed: .constant(true))
    }
}
