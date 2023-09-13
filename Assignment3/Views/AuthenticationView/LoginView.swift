//
//  LoginView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 12/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var placeholder: String = ""
    @State private var onTabPassword = false
    @State private var onEditPass = false
    var body: some View {
        ZStack {
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack {
                //MARK: EMAIL OR USERNAME
                VStack(alignment: .leading, spacing:0){
                    Text("Email or username")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    CustomeTextFieldView(onEditPass: $onEditPass)
                }
                //MARK: PASSWORD
                VStack(alignment: .leading, spacing:0){
                    Text("Password")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    
                    CustomSecureTextFieldView(isEditing: $onEditPass)
                }
                
                
                //MARK: LOGIN BUTTON
                VStack(){
                    Button {
                        
                    } label: {
                        LoginTextView()
                    }
                }
                .padding(.top,45)
               Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




struct LoginTextView: View {
    var body: some View {
        Text("Log in")
            .foregroundColor(.black)
            .font(Font.custom("Gotham-Bold", size: 20))
            .tracking(-1)
            .frame(width: 100, height: 25)
            .padding()
            .background(Color("gray").opacity(0.6))
            .clipShape(Capsule())
    }
}
