//
//  CustomSecureTextField.swift
//  Assignment3
//
//  Created by Hữu Phước  on 12/09/2023.
//

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
