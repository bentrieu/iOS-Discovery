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
        try await AuthenticationManager.instance.signInWithGoogle(tokens: tokens)
    }
}
