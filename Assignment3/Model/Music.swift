//
//  Music.swift
//  Assignment3
//
//  Created by Hữu Phước  on 18/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Music : Codable,Identifiable {
    let id = UUID()
    let musicId : String
    var musicName : String?
    var imageUrl: String?
    var artistName: String?
    var file: String?
    var genre: String?
    var musicLength : Int?
    enum CodingKeys: String, CodingKey {
        case musicId = "music_id"
        case musicName = "music_name"
        case artistName = "artist_name"
        case imageUrl = "image_url"
        case genre
    }

}

class MusicViewModel : ObservableObject {
    @Published var musics = [Music]()
    private var db  = Firestore.firestore()
    
    static var shared = MusicViewModel()
    
    
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
                let artist_name = data["artist_name"] as? String ?? ""
                let image_url = data["image_url"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                return Music(musicId: music_id, musicName: music_name,imageUrl: image_url,  artistName: artist_name, genre: genre)
            }
        }
    }
    func findMusicById(_ musicId: String) async throws -> Music? {
        let query = db.collection("music").whereField("music_id", isEqualTo: musicId)

        let querySnapshot = try await query.getDocuments()

        guard let document = querySnapshot.documents.first else {
            return nil // Document doesn't exist
        }

        let musicData = document.data()
        let music = Music(
            musicId: musicData["music_id"] as? String ?? "",
            musicName: musicData["music_name"] as? String ?? "",
            imageUrl: musicData["image_url"] as? String ?? "",
            artistName: musicData["artist_name"] as? String ?? "",
            file: musicData["file"] as? String ?? "",
            genre: musicData["genre"] as? String ?? "",
            musicLength: musicData["music_length"] as? Int ?? 0
        )

        return music
    }
    func getMusicListFromAlbum(_ albumId: String) async throws -> [Music] {
        let query = db.collection("album").whereField("album_id", isEqualTo: albumId)

        let querySnapshot = try await query.getDocuments()

        var musics: [Music] = []

        for document in querySnapshot.documents {
            let musicListData = document.data()

            if let musicIds = musicListData["music_list"] as? [String] {
                let dispatchGroup = DispatchGroup()
                
                for musicId in musicIds {
                    dispatchGroup.enter()
                    
                    do {
                        if let music = try await findMusicById(musicId) {
                            musics.append(music)
                        }
                    } catch {
                        // Handle the error
                        print("Error fetching music with ID \(musicId): \(error.localizedDescription)")
                    }
                    
                    dispatchGroup.leave()
                }

                await dispatchGroup.wait()
            }
        }

        return musics
    }
    

}
