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


import SwiftUI
import PhotosUI

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var playlists: [DBPlaylist]? = nil
    
    //load current authenticated user into the user variable
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.instance.getAuthenticatedUser()
        self.user = try await UserManager.instance.getUser(userId: authDataResult.uid)
    }
    
    //get all playlist of a current user
    func loadUserPlaylist() async throws {
        self.playlists = try await PlaylistManager.instance.getAllPlaylist()
    }
    
    //update user name and re-fetch
    func updateUserProfile(usernameText: String) {
        guard let user else { return }
        Task {
            try await UserManager.instance.updateUserProfile(userId: user.userId, displayName:usernameText)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    //update user preferences and refetch
    func updateUserTheme(isDark: Bool) {
        guard let user else { return }
        Task {
            try await UserManager.instance.updateUserTheme(userId: user.userId, isDark: isDark)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    //add a new empty playlist to the user storage and refetch
    func addPlaylist() async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.addPlaylist()
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    //add a music into the current user playlist and refetch
    func addMusicToPlaylist(musicId: String, playlistId: String) async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.addMusicToPlaylist(musicId: musicId, playlistId: playlistId)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    //remove a music from the current user playlist and refetch
    func removeMusicFromPlaylist(musicId: String, playlistId: String) async throws {
        guard let user else { return }
        
        Task {
            try await PlaylistManager.instance.removeMusicFromPlaylist(musicId: musicId, playlistId: playlistId)
            self.user = try await UserManager.instance.getUser(userId: user.userId)
        }
    }
    
    //save the picked image into the user storage,  and refetch
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
    
    //sign the current user out
    func signOut() throws {
        try AuthenticationManager.instance.signOut()
    }
    
    //delete current user from the database
    func deleteUser() async throws {
        try await AuthenticationManager.instance.deleteUser()
    }
}
