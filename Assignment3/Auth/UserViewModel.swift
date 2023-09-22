//
//  UserViewModel.swift
//  Assignment3
//
//  Created by Ben Trieu on 22/09/2023.
//

import SwiftUI
import PhotosUI

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var playlists: [DBPlaylist]? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.instance.getAuthenticatedUser()
        self.user = try await UserManager.instance.getUser(userId: authDataResult.uid)
    }
    
    func loadUserPlaylist() async throws {
        self.playlists = try await PlaylistManager.instance.getAllPlaylist()
    }
    
    func updateUserProfile(usernameText: String) {
        guard let user else { return }
        Task {
            try await UserManager.instance.updateUserProfile(userId: user.userId, displayName:usernameText)
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
        guard let user else { return }
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            let (path, name) = try await StorageManager.instance.saveUserImage(data: data, userId: user.userId)
            print("success")
            print(path)
            print(name)
            let url = try await StorageManager.instance.getUrlForImage(path: path)
            try await UserManager.instance.updateProfileImageURL(userId: user.userId, path: url.absoluteString)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
}
