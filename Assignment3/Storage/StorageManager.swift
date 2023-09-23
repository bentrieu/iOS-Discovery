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
import FirebaseStorage
import UIKit

final class StorageManager {
    
    static let instance = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private func userReference() -> StorageReference {
        storage.child("users")
    }
    
    private func playlistReference() -> StorageReference {
        storage.child("playlists")
    }
    
    func getUrlForImage(path: String) async throws -> URL {
        return try await Storage.storage().reference(withPath: path).downloadURL()
    }
    
    func getData(path: String) async throws -> Data{
        return try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func getImage(path: String) async throws -> UIImage {
        let data = try await getData(path: path)
        
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        return image
    }
    
    func deleteUserImage() async throws {
        let userId = try AuthenticationManager.instance.getAuthenticatedUser().uid
        let user = try await UserManager.instance.getUser(userId: userId)
        
        if let url = user.profileImagePath {
            try await userReference().child("\(userId).jpeg").delete()
        }
    }

    //MARK: USER IMAGES
    func saveUserImage(data: Data, userId: String) async throws -> (path: String, name: String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
    
        let path = "\(userId).jpeg"
        let returnMetaData = try await userReference().child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnMetaData.path, let returnedName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func saveUserImage(image: UIImage, userId: String) async throws -> (path: String, name: String){
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await saveUserImage(data: data, userId: userId)
    }
    
    //MARK: PLAYLIST IMAGES
    func savePlaylistImage(data: Data, playlistId: String) async throws -> (path: String, name: String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
    
        let path = "\(playlistId).jpeg"
        let returnMetaData = try await userReference().child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnMetaData.path, let returnedName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func savePlaylistImage(image: UIImage, playlistId: String) async throws -> (path: String, name: String){
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await savePlaylistImage(data: data, playlistId: playlistId)
    }
}
