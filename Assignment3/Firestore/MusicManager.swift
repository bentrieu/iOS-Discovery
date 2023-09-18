//
//  MusicManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 18/09/2023.
//

import Foundation
import FirebaseStorage

final class MusicManager {
    
    static let instance = MusicManager()
    private init() {}
    
    func foo() {
        //get storage service
        let storage = Storage.storage()
        
        //get storage reference to upload, download, delete
        let storageRef = storage.reference()
    }
}
