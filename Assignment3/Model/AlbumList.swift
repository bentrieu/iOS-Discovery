//
//  AlbumList.swift
//  Assignment3
//
//  Created by Hữu Phước  on 19/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct AlbumList: Codable {
    var albumsId : String
    var albumList: [String]
    var albumsName: String
}
