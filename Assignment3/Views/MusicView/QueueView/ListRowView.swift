//
//  TrackRowView.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct ListRowView: View {
    let imgName: String
    let imgDimens: CGFloat
    let title: String
    let titleSize: CGFloat
    let subTitle: String
    let subTitleSize: CGFloat
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width/25){
            Image(imgName)
                .resizable()
                .frame(width: imgDimens, height: imgDimens)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .modifier(Img())
            VStack{
                Text(title)
                    .font(.custom("Gotham-Medium", size: titleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(subTitle)
                    .font(.custom("Gotham-Book", size: subTitleSize))
                    .modifier(OneLineText())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(width: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(imgName: "testImg", imgDimens: 60, title: "Song Name", titleSize: 21, subTitle: "Artists", subTitleSize: 17)
    }
}
