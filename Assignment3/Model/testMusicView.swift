//
//  testMusicView.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import SwiftUI

struct testMusicView: View {
    @StateObject var viewModel = MusicViewModel()
    @StateObject var albumModel = AlbumViewModel()
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
                albumModel.addAlbum(Album(albumId: "0", imageUrl: "none" ,title: "Young, Dumb and Broke",  type: "Album", artistName: "Khalid" ))
            }
            Button("Delete album"){
                print("delete")
                albumModel.deleteByAlbumId("1")
            }
        }
        }
    
}

struct testMusicView_Previews: PreviewProvider {
    static var previews: some View {
        testMusicView()
    }
}
