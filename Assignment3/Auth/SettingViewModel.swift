//
//  SettingViewModel.swift
//  Assignment3
//
//  Created by Ben Trieu on 23/09/2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.instance.getProvider() {
            authProviders = providers
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.instance.signOut()
    }
    
    //just demo, add an email field later to get email for resetPassword
    func resetPassword() async throws{
        let authUser = try AuthenticationManager.instance.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.instance.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "const@gmail.com"
        try await AuthenticationManager.instance.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let pass = "12345678"
        try await AuthenticationManager.instance.updatePassword(password: pass)
    }
    
    func deleteUser() async throws {
        try await AuthenticationManager.instance.deleteUser()
    }
}
