//
//  Music.swift
//  Assignment3
//
//  Created by Hữu Phước  on 18/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Music : Codable {
    let musicId : String
    var musicName : String?
    var imageUrl: String?
    var artistName: String?
    var genre: String?
    
    enum CodingKeys: String, CodingKey {
        case musicId = "music_id"
        case musicName = "music_name"
        case imageUrl = "image_url"
        case artistName = "artist_name"
        case genre
    }

}

class MusicViewModel : ObservableObject {
    @Published var musics = [Music]()
    private var db  = Firestore.firestore()
    init() {
        getAllMusicData()
        print("get music in model")
    }
    func getAllMusicData() {
        db.collection("music").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No document")
                return
            }
            self.musics = documents.map {(queryDocumentSnapshot) -> Music in
                let data  = queryDocumentSnapshot.data()
                let music_name = data["music_name"] as? String ?? ""
                let music_id = data["music_id"] as? String ?? ""
                let image_url = data["image_url"] as? String ?? ""
                let artist_name = data["artist_name"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                return Music(musicId: music_id, musicName: music_name, imageUrl: image_url, artistName: artist_name, genre: genre)
            }
        }
    }
    func findMusicById(_ musicId: String, completion: @escaping (Result<Music?, Error>) -> Void) {
        let query = db.collection("music").whereField("music_id", isEqualTo: musicId)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents, let document = documents.first else {
                completion(.success(nil)) // Document doesn't exist
                return
            }

            do {
                let musicData = document.data()
                let music = Music(
                    musicId: musicData["music_id"] as? String ?? "",
                    musicName: musicData["music_name"] as? String ?? "",
                    imageUrl: musicData["image_url"] as? String ?? "",
                    artistName: musicData["artist_name"] as? String ?? "",
                    genre: musicData["genre"] as? String ?? ""
                )
                completion(.success(music))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
