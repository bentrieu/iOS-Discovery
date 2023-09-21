//
//  TempProfileView.swift
//  Assignment3
//
//  Created by Ben Trieu on 16/09/2023.
//

import SwiftUI
import FacebookLogin
import FacebookCore
import PhotosUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var playlists: [DBPlaylist]? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.instance.getAuthenticatedUser()
        self.user = try await UserManager.instance.getUser(userId: authDataResult.uid)
    }
    
    func loadUserPlaylist() async throws {
        self.playlists = try await PlaylistManager.instance.getAllPlaylist()
    }
    
    func updateUserProfile(usernameText: String, biographyText: String, photoUrl: String) {
        guard let user else { return }
        Task {
            try await UserManager.instance.updateUserProfile(userId: user.userId, displayName:usernameText, biography:biographyText,photoUrl:photoUrl)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    func addPlaylist() async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.addPlaylist()
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    func addMusicToPlaylist(musicId: String, playlistId: String) async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.addMusicToPlaylist(musicId: musicId, playlistId: playlistId)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    func removeMusicFromPlaylist(musicId: String, playlistId: String) async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.removeMusicFromPlaylist(musicId: musicId, playlistId: playlistId)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    func saveProfileImage(item: PhotosPickerItem) {
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            let (path, name) = try await StorageManager.instance.saveImage(data: data)
            print("success")
            print(path)
            print(name)
        }
    }
}

struct TempProfileView: View {
    
    @State var usernameText: String
    @State var biographyText: String
    @State var photoUrl: String
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    @State private var item: PhotosPickerItem? = nil
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Group {
                    Text("Userid: \(user.userId)")
                    TextField("Username", text: $usernameText)
                    TextField("Biography", text: $biographyText)
                    TextField("Photo url", text: $photoUrl)
                }
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
                
                HStack {
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
                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
                    Text("select an image")
                }
                if let playlists = viewModel.playlists {
                    List {
                        ForEach(playlists, id:\.playlistId) { item in
                            Text("\(item.playlistId)")
                        }
                    }
                }
            }
        }
        .onChange(of: item, perform: { newValue in
            if let newValue {
                viewModel.saveProfileImage(item: newValue)
            }
        })
        .onAppear {
            Task {
                do {
                    try? await viewModel.loadCurrentUser()
                    try? await viewModel.loadUserPlaylist()
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
