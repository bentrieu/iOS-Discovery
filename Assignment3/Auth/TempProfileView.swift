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
    
    func updateUserProfile(usernameText: String, biographyText: String, photoUrl: String) {
        guard let user else { return }
        Task {
            try await UserManager.instance.updateUserProfile(userId: user.userId, displayName:usernameText, biography:biographyText,photoUrl:photoUrl)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    func addPlaylist() async throws {
        try await PlaylistManager.instance.addPlaylist()
    }
    
    func addMusicToPlaylist(musicId: String, playlistId: String) async throws {
        try await PlaylistManager.instance.addMusicToPlaylist(musicId: musicId, playlistId: playlistId)
    }
    
    func removeMusicFromPlaylist(musicId: String, playlistId: String) async throws {
        try await PlaylistManager.instance.removeMusicFromPlaylist(musicId: musicId, playlistId: playlistId)
    }
}

struct TempProfileView: View {
    
    @State var usernameText: String
    @State var biographyText: String
    @State var photoUrl: String
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("Userid: \(user.userId)")
                TextField("Username", text: $usernameText)
                TextField("Biography", text: $biographyText)
                TextField("Photo url", text: $photoUrl)
                Button {
                    viewModel.updateUserProfile(usernameText: usernameText, biographyText: biographyText, photoUrl: photoUrl)
                } label: {
                    Text("Save")
                }
                
                if let email = user.email {
                    Text("Email: \(email)")
                }
                if let photoUrl = user.photoUrl {
                    Text("photoUrl: \(photoUrl)")
                }
                if let date = user.dateCreated {
                    Text("photoUrl: \(date.description)")
                }
                
                Button {
                    Task {
                        do {
                            try await viewModel.addPlaylist()
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Add playlist")
                }
                
                Group {
                    Button {
                        Task {
                            do {
                                try await viewModel.addMusicToPlaylist(musicId: "1", playlistId: "v8AtiDouY7nv1napA7Uv")
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Text("Add music")
                    }
                    Button {
                        Task {
                            do {
                                try await viewModel.addMusicToPlaylist(musicId: "2", playlistId: "v8AtiDouY7nv1napA7Uv")
                            } catch {
                                print(error)
                            }
                        }

                    } label: {
                        Text("Add music 2")
                    }
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.removeMusicFromPlaylist(musicId: "1", playlistId: "v8AtiDouY7nv1napA7Uv")
                            } catch {
                                print(error)
                            }
                        }


                    } label: {
                        Text("remove music")
                    }
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.removeMusicFromPlaylist(musicId: "2", playlistId: "v8AtiDouY7nv1napA7Uv")
                            } catch {
                                print(error)
                            }
                        }

                    } label: {
                        Text("remove music 2")
                    }
                }
                

            }
        }
        .onAppear {
            Task {
                do {
                    try? await viewModel.loadCurrentUser()
                } catch {
                    print(error)
                }
            }
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
        TempProfileView(usernameText: "", biographyText: "", photoUrl: "", showSignInView: .constant(false))
    }
}
