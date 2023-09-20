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
    
    static var shared = AlbumManager()
    private var db = Firestore.firestore()
    private var albumsCollectionRef: CollectionReference {
        return db.collection("album")
    }
    
   
    
    init() {
        
    }

    func fetchAlbums(completion: @escaping ([Album]?, Error?) -> Void) {
        albumsCollectionRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching albums: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No document")
                completion([], nil)
                return
            }
            let albums = documents.map { (queryDocumentSnapshot) -> Album in
                let data = queryDocumentSnapshot.data()
                let album_name = data["artist_name"] as? String ?? ""
                let image_url = data["image_url"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let album_id = data["album_id"] as? String ?? ""
                let music_list = data["music_list"] as? [String] ?? [""]
                return Album(albumId: album_id, imageUrl: image_url, title: title, type: type, artistName: album_name, musicList: music_list)
            }
            completion(albums, nil)
        }
    }
    
    func findAlbumById(_ albumId: String) async throws -> Album? {
        let query = db.collection("album").whereField("album_id", isEqualTo: albumId)

        let querySnapshot = try await query.getDocuments()

        guard let document = querySnapshot.documents.first else {
            return nil // Document doesn't exist
        }

        let albumData = document.data()
        let album = Album(
            albumId: albumData["album_id"] as? String ?? "",
            imageUrl: albumData["image_url"] as? String ?? "",
            title: albumData["title"] as? String ?? "",
            type: albumData["type"] as? String ?? "",
            artistName: albumData["artist_name"] as? String ?? "",
            musicList: albumData["music_list"] as? [String] ?? []
        )

        return album
    }
    func fetchPopularAlbumList() async throws -> [Album] {
        let query = db.collection("albums").whereField("albums_name", isEqualTo: "Popular Albums")

        let querySnapshot = try await query.getDocuments()

        var albums: [Album] = []

        for document in querySnapshot.documents {
            let albumListData = document.data()

            if let albumIds = albumListData["album_list"] as? [String] {
                let dispatchGroup = DispatchGroup()
                for albumId in albumIds {
                    dispatchGroup.enter()
                    do {
                        if let album = try await findAlbumById(albumId) {
                            albums.append(album)
                        }
                    } catch {
                        // Handle the error
                        print("Error fetching album with ID \(albumId): \(error.localizedDescription)")
                    }

                    dispatchGroup.leave()
                }

                await dispatchGroup.wait()
            }
        }

        return albums
    }
    func addAlbum(_ album: Album) {
        do {
            let albumRef = self.albumsCollectionRef.addDocument(data: [
                "image_url": album.imageUrl,
                "title": album.title,
                "type": album.type,
                "artist_name": album.artistName,
                "music_list": album.musicList
            ])
            
            let documentName = albumRef.documentID // Get the Firestore document ID
            var tempAlbum = album
            tempAlbum.albumId = documentName // Set the album_id using the document ID
            
            try albumRef.setData(from: tempAlbum, merge: true)
        } catch {
            print("Error adding album: \(error.localizedDescription)")
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
        let albumRef = albumsCollectionRef.document(albumId)
        
        // Delete the album document
        albumRef.delete { error in
            if let error = error {
                print("Error deleting album: \(error.localizedDescription)")
            } else {
                print("Album deleted successfully")
            }
        }
    }

    func getAlbumById(albumID: String, completion: @escaping (Result<Album?, Error>) -> Void) {
        let albumRef = albumsCollectionRef.document(albumID) // Use the document method to get the specific album document

        albumRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let document = document, document.exists {
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

    func searchAlbumByNameAndArtist(input : String) -> [Album]{
        var result = albums.filter { $0.title!.lowercased().contains(input.lowercased())}
        result += albums.filter{$0.artistName!.lowercased().contains(input.lowercased())}
        return result
    }


}
