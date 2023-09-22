//
//  StorageManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 21/09/2023.
//

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
