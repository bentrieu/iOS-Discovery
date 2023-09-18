//
//  Album.swift
//  Assignment3
//
//  Created by Hữu Phước  on 18/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct Album: Codable {
    var albumId : String
    var imageUrl: String?
    var title: String?
    var type: String?
    var artistName: String?
    var musicList : [String]
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case imageUrl = "image_url"
        case title = "title"
        case type = "type"
        case artistName = "artist_name"
        case musicList = "music_list"
    }
}

