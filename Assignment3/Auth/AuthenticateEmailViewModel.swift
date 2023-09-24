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


import Foundation

@MainActor
final class AuthenticateEmailViewModel: ObservableObject {
    
    //email and password for login
    @Published var email: String = ""
    @Published var password: String = ""
    
    //sign up the user into the auth and database
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        let authDataResult = try await AuthenticationManager.instance.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    //sign the user in using password and email
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        try await AuthenticationManager.instance.signInUser(email: email, password: password)
    }
}
