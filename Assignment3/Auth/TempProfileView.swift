//
//  TempProfileView.swift
//  Assignment3
//
//  Created by Ben Trieu on 16/09/2023.
//

import SwiftUI
import FacebookLogin
import FacebookCore

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.instance.getAuthenticatedUser()
        self.user = try await UserManager.instance.getUser(userId: authDataResult.uid)
    }
}

struct TempProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("Userid: \(user.userId)")
                if let email = user.email {
                    Text("Email: \(email)")
                }
                if let photoUrl = user.photoUrl {
                    Text("photoUrl: \(photoUrl)")
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    TempSettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct TempProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TempProfileView(showSignInView: .constant(false))
    }
}
