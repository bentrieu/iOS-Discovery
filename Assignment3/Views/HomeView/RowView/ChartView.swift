//
//  ChartView.swift
//  Assignment3
//
//  Created by Hữu Phước  on 22/09/2023.
//

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
