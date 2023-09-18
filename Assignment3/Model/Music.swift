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
    var musicName : String
    var imageURL: String
    var artistName: String
    var genere: String
}

final class MusicManager {
    static let instance = MusicManager()
    private init(){}
    private let musicCollection = Firestore.firestore().collection("music")
    private func musicDocument(musicId: String) -> DocumentReference {
        musicCollection.document(musicId)
    }
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
    func getMusic(musicId: String) async throws -> Music {
        return try await musicDocument(musicId: musicId).getDocument(as: Music.self, decoder: decoder)
    }
    func getAllMusic(completion: @escaping (Result<[Music], Error>) -> Void) {
        musicCollection.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                completion(.success([])) // No documents found
                return
            }

            let musicItems: [Music] = documents.compactMap { document in
                do {
                    let music = try document.data(as: Music.self, decoder: self.decoder)
                    return music
                } catch {
                    print("Error decoding document: \(error)")
                    return nil
                }
            }

            completion(.success(musicItems))
        }
    }
}
