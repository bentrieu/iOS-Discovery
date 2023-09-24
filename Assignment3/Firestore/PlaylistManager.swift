/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Minh Quan, Dinh Huu Gia Phuoc, Vu Gia An, Trieu Hoang Khang, Nguyen Tran Khang Duy
  ID: s3877969, s3878270, s3926888, s3878466, s3836280
  Created  date: 10/9/2023
  Last modified: 23/9/2023
  Acknowledgement:
https://rmit.instructure.com/courses/121597/pages/w9-whats-happening-this-week?module_item_id=5219569
https://rmit.instructure.com/courses/121597/pages/w10-whats-happening-this-week?module_item_id=5219571
*/

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBPlaylist: Codable {
    let playlistId: String
    let dateCreated: Date?
    let photoUrl: String?
    let name: String?
    let musics: [String]?
}

final class PlaylistManager : ObservableObject{
    @Published var playlists =  [DBPlaylist]()
    
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
    
    func getPlaylistsRef() async throws -> CollectionReference {
        return try await userCollection.document(getCurrentUser()).collection("playlists")
    }

//    func getPlaylistsRef() async throws -> CollectionReference {
//        return try await userCollection.document("mW8JeXNn48bI1annfiBM4x6pSdz2").collection("playlists")
//    }
//    
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
    
    func addPlaylist(name : String) async throws {
        var playlistData: [String: Any] = [
            "playlist_id": "",
            "name": name,
            "date_created": Timestamp(),
            "photo_url": "",
            "musics": []
        ]
        
        let playlistRef = try await getPlaylistsRef().addDocument(data: playlistData)
        let playlistId = playlistRef.documentID
        
        playlistData["playlist_id"] = playlistId
        
        try await getPlaylistsRef().document(playlistId).setData(playlistData)
    }
    
    func removePlaylist(playlistId: String) async throws {
        try await getPlaylistsRef().document(playlistId).delete()
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
    
    func updatePlaylistName(playlistId: String, name: String) async throws {
        let playlistData: [String: Any] = [
            "name": name,
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(playlistData)
    }
    
    func updatePlaylistPhoto(playlistId: String, photoUrl: String) async throws {
        let playlistData: [String: Any] = [
            "photo_url": photoUrl,
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(playlistData)
    }
    
    func setMusicsToPlaylist(musicIds: [String], playlistId: String) async throws {
        let data: [String: Any] = [
            "musics": musicIds
        ]
        
        try await getPlaylistsRef().document(playlistId).updateData(data)
    }
    
    func getPlaylistFromLocal(playlistId : String) -> DBPlaylist{
        return playlists.first(where: {$0.playlistId == playlistId})!
    }
    
    func searchPlaylistByName(input : String) -> [DBPlaylist]{
        return playlists.filter { $0.name!.lowercased().contains(input.lowercased()) }
    }
    
    func getAllMusicsInPlaylist(playlistId : String)-> [Music]{
        //get all music ids in playlist
        let playlistTrackIds = playlists.first(where: {$0.playlistId == playlistId})?.musics ?? [String]()
        
        var playlistTracks = [Music]()
        //map the id with the real Music instance and put in the array above
        for id in playlistTrackIds{
            for music in MusicViewModel.shared.musics{
                if id == music.musicId{
                    playlistTracks.append(music)
                    break
                }
            }
        }
        return playlistTracks
    }
    
    func searchMusicInAListByNameAndArtist(input : String, musics: [Music]) -> [Music]{
        if input.isEmpty{
            return musics
        }else{
            //filter with music name first
            var result = musics.filter { $0.musicName!.lowercased().contains(input.lowercased()) }
            
            //search by artist later with checking duplicate instances
            let artistResult = musics.filter{$0.artistName!.lowercased().contains(input.lowercased())}
            for music in artistResult {
                if !result.contains(where: {$0.musicId == music.musicId}){
                    result.append(music)
                }
            }
            return result
        }
    }
}
