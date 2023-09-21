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
    
    func getProfileData(userId: String) async throws -> Data{
        return try await userReference().child("\(userId).jpeg").data(maxSize: 3 * 1024 * 1024)
    }
    
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
    
        let path = "\(userId).jpeg"
        let returnMetaData = try await userReference().child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnMetaData.path, let returnedName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func saveImage(image: UIImage, userId: String) async throws -> (path: String, name: String){
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
        
        return try await saveImage(data: data, userId: userId)
    }

}
