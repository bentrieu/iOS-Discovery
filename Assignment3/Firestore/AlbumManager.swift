//
//  AlbumManager.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AlbumManager : ObservableObject {
    @Published var albums = [Album]()
    private var db = Firestore.firestore()
    private var albumsCollectionRef: CollectionReference {
        return db.collection("album")
    }
    private var counterManager = CounterManager.instance
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
                let music_list = data["music_list"] as? [String] ?? [""]
                return Album(albumId: album_id, imageUrl: image_url, title: title, type: type, artistName: album_name, musicList: music_list)
            }

        }
    }

    func addAlbum(_ album: Album) {
        let counterName = "album"
        counterManager.getAndIncrementCounter(counterName: counterName) { result in
            switch result {
            case .success(let counterValue):
                do {
                    let documentName = String(counterValue)
                    let albumRef = self.albumsCollectionRef.document(documentName)
                    var tempAlbum = album
                    tempAlbum.albumId = documentName // Set the album_id using the counter value
                    
                    try albumRef.setData(from: tempAlbum)
                } catch {
                    print("Error adding album: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error incrementing counter: \(error.localizedDescription)")
            }
        }
    }



    func updateAlbum(_ album: Album) {
        let albumID = album.albumId
        
        // Use the Firestore document reference for the specified albumID within the correct collection
        let albumRef = albumsCollectionRef.document(albumID)

        do {
            // Use setData to update the document with the data from the Album object
            try albumRef.setData(from: album, merge: true) // Use merge: true to merge changes
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
    
    func getAlbumById(albumID: String, completion: @escaping (Result<Album?, Error>) -> Void) {
        let albumsCollectionRef = db.collection("album") // Adjust the collection name as needed

        // Create a query to find the album with the matching albumId field
        let query = albumsCollectionRef.whereField("album_id", isEqualTo: albumID)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let document = querySnapshot?.documents.first {
                do {
                    let album = try document.data(as: Album.self)
                    completion(.success(album))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.success(nil)) // Album not found
            }
        }
    }

    func addMusicToAlbum(albumId: String, musicId: String) {
        getAlbumById(albumID: albumId) { result in
            switch result {
            case .success(var fetchedAlbum):
                if var album = fetchedAlbum {
                    if album.musicList == nil {
                        album.musicList = [musicId]
                    } else {
                        album.musicList.append(musicId)
                    }
                    self.updateAlbum(album)
                } else {
                    print("Album not found")
                }
            case .failure(let error):
                print("Error fetching album: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteMusicFromAlbum(albumId: String, musicId: String) {
        getAlbumById(albumID: albumId) { result in
            switch result {
            case .success(var fetchedAlbum):
                if var album = fetchedAlbum {
                    if let index = album.musicList.firstIndex(of: musicId) {
                        album.musicList.remove(at: index)
                        self.updateAlbum(album)
                    } else {
                        print("Music not found in the album")
                    }
                } else {
                    print("Album not found")
                }
            case .failure(let error):
                print("Error fetching album: \(error.localizedDescription)")
            }
        }
    }

    


}
