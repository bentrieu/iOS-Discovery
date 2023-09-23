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

struct CustomSecureTextFieldView: View {
    @Binding var password: String
    @Binding var isEditing: Bool
    @State private var isEyeOpen = false
    var body: some View {
        VStack{
            if isEyeOpen{
                VStack{
                    TextField("", text: $password) { edit in
                        self.isEditing = edit
                    }
                    .textFieldStyle(CustomTextSecureFieldStyle(focus: $isEditing))
                }
            }else{
                VStack{
                    SecureField("", text: Binding<String>(
                        get: { self.password },
                        set: { self.password = $0
                            self.isEditing = true
                           }
                         ))
                }
                .textFieldStyle(CustomTextSecureFieldStyle(focus: $isEditing))
            }
        }
        .overlay {
            HStack {
                Spacer()
                Color.clear
                    .frame(width: 70)
                    .overlay {
                        Button {
                            isEyeOpen.toggle()
                        } label: {
                            Image(systemName: isEyeOpen ?  "eye" : "eye.slash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .foregroundColor(.white)
                        }
                    }
            }
        }
    }
    
}


struct CustomSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextFieldView(password: .constant(""), isEditing: .constant(true))
    }
}

struct CustomTextSecureFieldStyle: TextFieldStyle {
    @Binding var focus: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(CustomTextFieldStyle(focus: $focus))
            .autocorrectionDisabled()
            
    }
}
