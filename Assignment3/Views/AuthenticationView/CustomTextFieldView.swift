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

struct CustomeTextFieldView: View {
    
    @Binding var name: String
    @State private var onEditing = false
    @Binding var onEditPass : Bool
    var body: some View {
        VStack {
            TextField("", text: $name,onEditingChanged: { edit in
                self.onEditing = edit
                onEditPass = false
            })
            .textFieldStyle(CustomTextFieldStyle(focus: $onEditing))
        }
    }
}

struct CustomeTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomeTextFieldView(name: .constant(""),onEditPass: .constant(true))
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    @Binding var focus: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height:15)
            .font(Font.custom("Gotham-Medium", size: 13))
            .foregroundColor(.white)
            .padding(.vertical,20)
            .padding(.horizontal)
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .fill(focus ? Color("light-gray" ).opacity(0.6) : Color("gray").opacity(0.6))
            }
            .tint(Color("green"))
            
    }
}
