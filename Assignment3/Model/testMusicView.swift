//
//  testMusicView.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import SwiftUI

struct testMusicView: View {
    @StateObject var viewModel = MusicViewModel()
    @StateObject var albumModel = AlbumManager()
    var body: some View {
        VStack {
            Button("Click me") {
                print("Click")
                for album in albumModel.albums {
                    print("in func")
                    print(album)
                }
            }
            Button("Add album") {
                print("add")
                albumModel.addAlbum(Album(albumId: "0", imageUrl: "none" ,title: "V",  type: "Album", artistName: "Maroon 5", musicList: [""]))
            }
            Button("Delete album"){
                print("delete")
                albumModel.deleteByAlbumId("73iWHnrdh4DfWdDjwPdW")
            }
            Button("Add music to album"){
                print("album id: 1, music id: 1")
                albumModel.addMusicToAlbum(albumId: "ecmL9AZEFHgQ9Ritrc69", musicId: "1")
            }
            Button("remove music from album"){
                print("album id: ecmL9AZEFHgQ9Ritrc69, music id: 1")
                albumModel.deleteMusicFromAlbum(albumId: "ecmL9AZEFHgQ9Ritrc69", musicId: "1")
            }
            
        }
        }
    
}

struct testMusicView_Previews: PreviewProvider {
    static var previews: some View {
        testMusicView()
    }
}
