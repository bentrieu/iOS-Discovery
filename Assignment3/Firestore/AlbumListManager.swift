//
//  AlbumListManager.swift
//  Assignment3
//
//  Created by Hữu Phước  on 19/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AlbumListManager{
    
    static var shared = AlbumListManager()
    
    private var db = Firestore.firestore()
    init(){}
    
//    func findAlbumById(_ albumsName: String, completion: @escaping (Result<Album?, Error>) -> Void) {
//        let query = db.collection("albums").whereField("albums_name", isEqualTo: albumsName)
//
//        query.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let documents = querySnapshot?.documents, let document = documents.first else {
//                completion(.success(nil)) // Document doesn't exist
//                return
//            }
//
//            do {
//                let albumData = document.data()
//                let album = Album(albumId: albumData["album_id"] as? String ?? "",
//                                  imageUrl:albumData["image_url"] as? String ?? "",
//                                  title:albumData["title"] as? String ?? "",
//                                  type:albumData["type"] as? String ?? "",
//                                  artistName: albumData["artist_name"] as? String ?? "",
//                                  musicList: albumData["music_list"] as? [String] ?? [""])
//                completion(.success(album))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//    }
}
