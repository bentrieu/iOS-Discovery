//
//  TrackRowView.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct TrackRowView: View {
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/25){
            Image("testImg")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .modifier(Img())
            VStack{
                Text("Song Name")
                    .font(.custom("Gotham-Medium", size: 21))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Artists")
                    .font(.custom("Gotham-Book", size: 17))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(width: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView()
    }
}
