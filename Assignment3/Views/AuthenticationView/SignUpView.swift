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

struct SignUpView: View {
    @StateObject private var viewModel = AuthenticateEmailViewModel()
    @State private var errorMSG : String  = ""
    @Binding var showSignInView: Bool
    
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
                    TextField("", text: $viewModel.email, onEditingChanged: { edit in
                        isEditing = true
                    })
                    .textFieldStyle(CustomTextFieldStyle(focus: $isEditing))
                    .padding(.vertical,5)
                }
                //MARK: PASSWORD
                VStack(alignment: .leading, spacing:0){
                    Text("Password")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    
                    CustomSecureTextFieldView(password: $viewModel.password, isEditing: $isEditing)
                }
                VStack(){
                    Button {
                        Task {
                            do {
                                try await viewModel.signUp()
                                showSignInView = false
                            } catch {
                                errorMSG = error.localizedDescription
                            }
                        }
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(.black)
                            .font(Font.custom("Gotham-Bold", size: 20))
                            .tracking(-1)
                            .frame(width: 100, height: 25)
                            .padding()
                            .background(Color("gray").opacity(0.6))
                            .clipShape(Capsule())
                    }
                }
                .padding(.top,45)
                Text(errorMSG)
                    .foregroundColor(Color("red"))
                    .font(Font.custom("Gotham-Bold", size: 10))
                    .padding(.vertical,5)
                    .tracking(0)
               Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignInView: .constant(false))
    }
}
