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
}
