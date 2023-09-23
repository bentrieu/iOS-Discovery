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

struct EditModalLeaveConfirmView: View {
    @Binding  var isPresentingEdit : Bool
    @Binding var isCancelButtonPressed: Bool
    var focusField: FocusState<Bool>.Binding
    
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
                        focusField.wrappedValue = false
                       
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

//struct EditModalLeaveConfirmView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditModalLeaveConfirmView(isPresentingEdit: .constant(true), isCancelButtonPressed: .constant(true))
//    }
//}
