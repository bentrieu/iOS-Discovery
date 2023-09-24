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
    
    @Binding var name: String          // Binding to the text in the text field
    @State private var onEditing = false // State to track editing state
    @Binding var onEditPass: Bool      // Binding to coordinate with another view
    
    var body: some View {
        VStack {
            // TextField with a custom focus style
            TextField("", text: $name, onEditingChanged: { edit in
                self.onEditing = edit
                onEditPass = false // Set onEditPass to false when editing changes
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
    @Binding var focus: Bool // Binding to track the focus state of the text field
    
    // The body function required for TextFieldStyle
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 15) // Set the height of the text field
            .font(Font.custom("Gotham-Medium", size: 13)) // Set the font and size
            .foregroundColor(.white) // Set the text color to white
            .padding(.vertical, 20) // Add vertical padding
            .padding(.horizontal) // Add horizontal padding
            .background {
                RoundedRectangle(cornerRadius: 5) // Create a rounded rectangle background
                    .fill(focus ? Color("light-gray").opacity(0.6) : Color("gray").opacity(0.6)) // Set the fill color based on the focus state
            }
            .tint(Color("green")) // Set the tint color (used for the clear button)
    }
}

