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

