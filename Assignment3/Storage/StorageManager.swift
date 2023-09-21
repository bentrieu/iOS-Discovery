//
//  StorageManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 21/09/2023.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let instance = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    func saveImage(data: Data) async throws -> (path: String, name: String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
    
        let path = "\(UUID().uuidString).jpeg"
        let returnMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnMetaData.path, let returnedName = returnMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
        
        
    }
}
