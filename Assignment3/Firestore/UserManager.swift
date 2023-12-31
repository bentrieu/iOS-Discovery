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

//user model to store user within the database
struct DBUser: Codable {
    let userId: String
    let dateCreated: Date?
    let email: String?
    let displayName: String?
    let favorites: [String]?
    let profileImagePath: String?
    let isDark: Bool?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.dateCreated = Date()
        self.email = auth.email
        self.displayName = auth.displayName
        self.favorites = []
        self.profileImagePath = nil
        self.isDark = false
    }
}

final class UserManager {
    
    static let instance = UserManager()
    private init() {}
    
    //reference to user collection within the database
    private let userCollection = Firestore.firestore().collection("users")
    
    //get a document from a user
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    //to encode from normal case to snake case
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    //to decode from snake case to normal case
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    //create a user within the database if not exist
    func createNewUser(user: DBUser) async throws {
        let isUserExists = try await userDocument(userId: user.userId).getDocument().exists
        if !isUserExists {
            try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
        }
    }
    
    //get a user using id
    func getUser(userId: String) async throws -> DBUser {
        return try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    //delete current user
    func deteleCurrentUser() async throws {
        try await userDocument(userId: AuthenticationManager.instance.getAuthenticatedUser().uid).delete()
    }
    
    //update user display name
    func updateUserProfile(userId:String, displayName: String) async throws {
        let data: [String:Any] = [
            "display_name": displayName
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    //update user profile image
    func updateProfileImageURL(userId:String, path: String) async throws {
        let data: [String:Any] = [
            "profile_image_path": path
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    //update user theme reference
    func updateUserTheme(userId:String, isDark: Bool) async throws {
        let data: [String:Any] = [
            "is_dark": isDark
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    //add a new music to user favorite array
    func favoriteMusic(musicId: String, userId: String) async throws {
        let data: [String: Any] = [
            "favorites": FieldValue.arrayUnion([musicId])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    //remove a music from user favorite array
    func unfavoriteMusic(musicId: String, userId: String) async throws {
        let data: [String: Any] = [
            "favorites": FieldValue.arrayRemove([musicId])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
}
