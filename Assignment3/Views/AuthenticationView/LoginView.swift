//
//  LoginView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 12/09/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthenticateEmailViewModel()
    @State private var placeholder: String = ""
    @State private var onTabPassword = false
    @State private var onEditPass = false
    @State private var errorMSG : String  = ""
    @State private var navigateToRootViewTemp: Bool = false
    
    var body: some View {
        ZStack {
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack {
                //MARK: EMAIL OR USERNAME
                VStack(alignment: .leading, spacing:0){
                    Text("Email")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    CustomeTextFieldView(name: $viewModel.email,onEditPass: $onEditPass)
                }
                //MARK: PASSWORD
                VStack(alignment: .leading, spacing:0){
                    Text("Password")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    
                    CustomSecureTextFieldView(password: $viewModel.password,isEditing: $onEditPass)
                }
                
                
                //MARK: LOGIN BUTTON
                VStack(){
                    Button {
                        Task {
                            do {
                                try await viewModel.signUp()
                                navigateToRootViewTemp = true
                            } catch {
                                errorMSG = error.localizedDescription
                            }
                        }
                    } label: {
                        LoginTextView()
                    }
                }
                .padding(.top,45)
                Text(errorMSG)
                    .foregroundColor(Color("red"))
                    .font(Font.custom("Gotham-Bold", size: 10))
                    .padding(.vertical,5)
                    .tracking(0)
               Spacer()
                NavigationLink("", destination: MainView(), isActive: $navigateToRootViewTemp)
                    .opacity(0) // Hide the link view, it will navigate when navigateToRootViewTemp is true
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
