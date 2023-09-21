//
//  PlaylistManager.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBPlaylist: Codable {
    let playlistId: String
    let dateCreated: Date?
    let photoUrl: String?
    let displayName: String?
    let musics: [String]?
    
//    init(playlistId: String,
//    dateCreated: Date? = Date(),
//    photoUrl: String? = nil,
//    displayName: String?) {
//        self.playlistId = playlistId
//        self.dateCreated = dateCreated
//        self.photoUrl = photoUrl
//        self.displayName = displayName
//    }
}

final class PlaylistViewModel :ObservableObject{
    @Published var playlists =  [DBPlaylist]()
    static let instance = PlaylistViewModel()
    
    
    //    func searchPlaylistByName(input : String) -> [DBPlaylist]{
    //        return playlists.filter { $0.displayName!.lowercased().contains(input.lowercased()) }
    //    }
}

final class PlaylistManager : ObservableObject{
    
    
    static let instance = PlaylistManager()
    private init() {}
        
    private let userCollection = Firestore.firestore().collection("users")
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getCurrentUser() async throws -> String {
        return try AuthenticationManager.instance.getAuthenticatedUser().uid
    }
    
//    func getPlaylistsRef() async throws -> CollectionReference {
//        return try await userCollection.document(getCurrentUser()).collection("playlists")
//    }
    
    func getPlaylistsRef() async throws -> CollectionReference {
        return try await userCollection.document("mW8JeXNn48bI1annfiBM4x6pSdz2").collection("playlists")
    }
    
    func addPlaylist() async throws {
        var playlistData: [String: Any] = [
            "playlist_id": "",
            "name": "Playlist",
            "date_created": Timestamp(),
            "photo_url": "",
            "musics": []
        ]
        
        let playlistRef = try await getPlaylistsRef().addDocument(data: playlistData)
        let playlistId = playlistRef.documentID
        
        playlistData["playlist_id"] = playlistId
        
        try await getPlaylistsRef().document(playlistId).setData(playlistData)
    }
    
    func getPlaylist(playlistId: String) async throws -> DBPlaylist {
        return try await getPlaylistsRef().document(playlistId).getDocument(as: DBPlaylist.self, decoder: decoder)
    }
    
    func getAllPlaylist() async throws -> [DBPlaylist] {
        let snapshot = try await getPlaylistsRef().getDocuments()
        
        var playlists: [DBPlaylist] = []
        
        for document in snapshot.documents {
            let playlist = try document.data(as: DBPlaylist.self, decoder: decoder)
            playlists.append(playlist)
        }
        
        return playlists
    }
    
    func addMusicToPlaylist(musicId: String, playlistId: String) async throws {
        let data: [String: Any] = [
            "musics": FieldValue.arrayUnion([musicId])
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(data)
    }
    
    func removeMusicFromPlaylist(musicId: String, playlistId: String) async throws {
        let data: [String: Any] = [
            "musics": FieldValue.arrayRemove([musicId])
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(data)
    }
    
    func updatePlaylistInfo(playlistId: String, name: String, photoUrl: String) async throws {
        let playlistData: [String: Any] = [
            "name": name,
            "photo_url": photoUrl,
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(playlistData)
    }
    

}
