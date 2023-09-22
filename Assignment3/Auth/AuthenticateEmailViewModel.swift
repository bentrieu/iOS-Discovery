//
//  SignUpEmailViewModel.swift
//  Assignment3
//
//  Created by Ben Trieu on 17/09/2023.
//

import Foundation

@MainActor
final class AuthenticateEmailViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        let authDataResult = try await AuthenticationManager.instance.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        try await AuthenticationManager.instance.signInUser(email: email, password: password)
    }
}
