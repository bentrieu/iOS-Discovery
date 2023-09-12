//
//  SignUpView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 12/09/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var email : String  = ""
    @State private var isEditing = false
    var body: some View {
        ZStack {
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack {
                //MARK: EMAIL OR USERNAME
                VStack(alignment: .leading, spacing:0){
                    Text("What's your email?")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    TextField("", text: $email, onEditingChanged: { edit in
                        isEditing = true
                    })
                    .textFieldStyle(CustomTextFieldStyle(focus: $isEditing))
                    Text("You'll need to confirm this email later.")
                        .foregroundColor(Color("black"))
                        .font(Font.custom("Gotham-Bold", size: 10))
                        .padding(.vertical,5)
                        .tracking(0)
                        
                }
                //MARK: PASSWORD
               Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
