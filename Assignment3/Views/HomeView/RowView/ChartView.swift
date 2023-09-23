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

struct ChartView: View {
    @State var albums: [Album] = []
    @State var musics : [Music] = []
    var body: some View {
        VStack(alignment: .leading) {
            Text("Charts")
                .foregroundColor(Color("black"))
                .font(Font.custom("Gotham-Bold", size: 24))
                .padding(.leading)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 17){
                    ForEach(AlbumListManager.shared.chart!, id: \.albumId) { item in
                        NavigationLink {
                            AlbumPageView(album: item)
                                .modifier(CustomNavigationButton())
                               
                        } label: {
                            VStack(alignment: .leading){
                                SquareView(imageUrl: item.imageUrl!, size: 160)
                                VStack(alignment: .leading, spacing: -5){
                                    Text(item.type!)
                                        .font(Font.custom("Gotham-Medium", size: 13))
                                        .padding(.top,5)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                                .offset(y:-10)
                                .foregroundColor(Color("black").opacity(0.6))
                                .frame(width: 160)
                            }
                        }
                    }
                }
                .padding(.leading,15)
            }
            
        }
        .onAppear{
            Task {
                do {
                    self.albums = try await AlbumManager.shared.getAlbumCollectionByName("Charts")
                    // Handle the albums
                } catch {
                    // Handle any errors that occur during the asynchronous operation
                    print("Error: \(error)")
                }
            }
            
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
