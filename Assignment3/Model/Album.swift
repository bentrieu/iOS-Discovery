//
//  Album.swift
//  Assignment3
//
//  Created by Hữu Phước  on 18/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Album: Codable {
    let albumId : String
    var imageUrl: String?
    var title: String?
    var type: String?
    var artistName: String?
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case imageUrl = "image_url"
        case title = "title"
        case type = "type"
        case artistName = "artist_name"
    }
}
class AlbumViewModel: ObservableObject {
    @Published var albums = [Album]()
    private var db = Firestore.firestore()
    private var albumsCollectionRef: CollectionReference {
        return db.collection("album")
    }

    init() {
        fetchAlbums()
    }

    func fetchAlbums() {
        albumsCollectionRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching albums: \(error.localizedDescription)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No document")
                return
            }
            self.albums = documents.map {(queryDocumentSnapshot) -> Album in
                let data = queryDocumentSnapshot.data()
                let album_name = data["artist_name"] as? String ?? ""
                let image_url = data["image_url"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let album_id = data["album_id"] as? String ?? ""
                return Album(albumId: album_id, imageUrl: image_url, title: title, type: type, artistName: album_name)
            }

        }
    }

    func addAlbum(_ album: Album) {
        do {
            let tempAlbum = Album(albumId: String(albums.count+1), imageUrl: album.imageUrl, title: album.title, type: album.type, artistName: album.artistName )
            _ = try albumsCollectionRef.addDocument(from: tempAlbum)
        } catch {
            print("Error adding album: \(error.localizedDescription)")
        }
    }

    func updateAlbum(_ album: Album) {
      let albumID = album.albumId
            do {
                try albumsCollectionRef.document(albumID).setData(from: album)
            } catch {
                print("Error updating album: \(error.localizedDescription)")
            }
        
    }

    func deleteByAlbumId(_ albumId: String) {
        // Use a query to find the album document with the specified albumId
        let query = albumsCollectionRef.whereField("album_id", isEqualTo: albumId)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error deleting album by albumId: \(error.localizedDescription)")
                return
            }

            if let documents = querySnapshot?.documents, let document = documents.first {
                document.reference.delete { error in
                    if let error = error {
                        print("Error deleting album: \(error.localizedDescription)")
                    } else {
                        print("Album with albumId \(albumId) deleted successfully.")
                    }
                }
            } else {
                print("Album with albumId \(albumId) not found.")
            }
        }
    }

}
