//
//  TempSettingsView.swift
//  Assignment3
//
//  Created by Ben Trieu on 10/09/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
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
}

struct TempSettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
            
            Section {
                Button("Reset password") {
                    Task {
                        do {
                            try await viewModel.resetPassword()
                            print("password reset")
                        } catch {
                            print("error: \(error)")
                        }
                    }
                }
                
                Button("Update password") {
                    Task {
                        do {
                            try await viewModel.updatePassword()
                            print("password updated")
                        } catch {
                            print("error: \(error)")
                        }
                    }
                }
                
                Button("Update email") {
                    Task {
                        do {
                            try await viewModel.updateEmail()
                            print("email updated")
                        } catch {
                            print("error: \(error)")
                        }
                    }
                }
            } header: {
                Text("Email function")
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct TempSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TempSettingsView(showSignInView: .constant(false))
        }
    }
}
