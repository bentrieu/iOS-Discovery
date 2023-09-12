//
//  CustomeTextField.swift
//  Assignment3
//
//  Created by Hữu Phước  on 12/09/2023.
//

import SwiftUI

struct CustomeTextFieldView: View {
    
    @State private var name = ""
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
        CustomeTextFieldView(onEditPass: .constant(true))
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
                    .fill(focus ? Color("light-gray" ) : Color("gray"))
            }
            .tint(Color("green"))
            
    }
}
