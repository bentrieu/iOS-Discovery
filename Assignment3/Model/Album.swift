//
//  Album.swift
//  Assignment3
//
//  Created by Hữu Phước  on 18/09/2023.
//

import Foundation

struct Album: Identifiable {
    let id = UUID()
    var imageUrl: String
    var title: String
    var type: String
    var name: String
}
