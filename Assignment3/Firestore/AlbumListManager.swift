//
//  AlbumListManager.swift
//  Assignment3
//
//  Created by Hữu Phước  on 19/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AlbumListManager: ObservableObject{
    @Published var popularAlbums :[Album]?
    @Published var chart :[Album]?
    
    static var shared = AlbumListManager()
    
    init(){
    }
}
