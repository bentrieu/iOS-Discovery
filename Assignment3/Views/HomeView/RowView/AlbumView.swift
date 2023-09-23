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

struct AlbumView : View {
    @State var albums: [Album] = []
    @State var musics : [Music] = []
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Album")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(AlbumListManager.shared.popularAlbums!, id: \.albumId) { item in
                        NavigationLink {
                            AlbumPageView(album: item)
                                .modifier(CustomNavigationButton())
                               
                        } label: {
                            VStack(alignment: .leading){
                                SquareView(imageUrl: item.imageUrl!, size: 160)
                                TextForAlbumView(title: item.title!, type: item.type!, name: item.artistName!, size: 160)
                            }
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .onAppear{
//            Task {
//                self.albums = try await AlbumManager.shared.getAlbumCollectionByName("Popular Albums")
//                print(self.albums)
//            }
            print(AlbumListManager.shared.popularAlbums)
        }
    }
}

struct RowForSquareView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumView()
        }
    }
}


struct TextForAlbumView: View {
    var title : String
    var type : String
    var name : String
    var size : CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: -5){
            Text(title)
                .tracking(-1)
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Medium", size: 16))
            HStack(spacing: 5){
                Text(type)
                
                Text(".")
                    .font(.system(size: 45))
                    .offset(y:-15)
                Text(name)
                    .tracking(-1)
                Spacer()
            }
            .offset(y:-10)
            .font(Font.custom("Gotham-Medium", size: 16))
            .foregroundColor(Color("black").opacity(0.6))
            .frame(width: size)
        }
    }
}








