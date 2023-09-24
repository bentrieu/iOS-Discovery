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

struct LoginView: View {
    @StateObject private var viewModel = AuthenticateEmailViewModel()
    @State private var placeholder: String = ""
    @State private var onTabPassword = false
    @State private var onEditPass = false
    @State private var errorMSG : String  = ""
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            // Set the background color to white, ignoring safe area edges.
            Color("white")
                .edgesIgnoringSafeArea(.all)
            VStack {
                //MARK: EMAIL OR USERNAME
                VStack(alignment: .leading, spacing:0){
                    // Display the "Email" label with a custom font and tracking.
                    Text("Email")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    // Include a custom text field for entering email/username.
                    CustomeTextFieldView(name: $viewModel.email,onEditPass: $onEditPass)
                }
                //MARK: PASSWORD
                VStack(alignment: .leading, spacing:0){
                    // Display the "Password" label with a custom font and tracking.
                    Text("Password")
                        .font(Font.custom("Gotham-Bold", size: 20))
                        .tracking(-1)
                    // Include a custom secure text field for entering the password.
                    CustomSecureTextFieldView(password: $viewModel.password,isEditing: $onEditPass)
                }
                
                //MARK: LOGIN BUTTON
                VStack(){
                    // Define a button that triggers the login action.
                    Button {
                        Task {
                            do {
                                // Attempt to sign in using the viewModel.
                                try await viewModel.signIn()
                                showSignInView = false
                            } catch {
                                errorMSG = error.localizedDescription
                            }
                        }
                    } label: {
                         // Display a button with the title "Log in."
                        ButtonTextField(title: "Log in")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showSignInView: .constant(false))
    }
}

struct ButtonTextField: View {
    var title : String
    var body: some View {
        Text(title)
            .foregroundColor(.black)
            .font(Font.custom("Gotham-Bold", size: 16))
            .tracking(-1)
            .frame(width: 85, height: 20)
            .padding()
            .background(Color("gray").opacity(0.6))
            .clipShape(Capsule())
    }
}
