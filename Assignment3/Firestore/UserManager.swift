//
//  UserManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 16/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    let  userId: String
    let  dateCreated: Date?
    let  email: String?
    let  photoUrl: String?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.dateCreated = Date()
        self.email = auth.email
        self.photoUrl = auth.photoUrl
    }
}

final class UserManager {
    
    static let instance = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
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
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user,merge: false, encoder: encoder)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        return try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
}
