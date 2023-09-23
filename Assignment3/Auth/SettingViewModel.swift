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
