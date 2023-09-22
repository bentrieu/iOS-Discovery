//
//  AuthenticationViewModel.swift
//  Assignment3
//
//  Created by Ben Trieu on 16/09/2023.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.instance.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.instance.createNewUser(user: user)
    }
    
    func signInFacebook() async throws -> FacebookLoginResult {
        let loginManager = FacebookSignInHelper()
        return try await loginManager.loginFacebook()
    }
}
