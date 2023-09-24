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
