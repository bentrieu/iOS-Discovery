//
//  QueueVIew.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct QueueVIew: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Now Playing")
                .font(.custom("Gotham-Bold", size: 25))
                .modifier(BlackColor())
            //MARK: - CURRENT TRACK
            Button {
                
            } label: {
                TrackRowView()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.4)).shadow(radius: 1))
            }
            Text("Up Next")
                .font(.custom("Gotham-Bold", size: 25))
                .modifier(BlackColor())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: - TRACK LIST
            List{
                Button{
                    
                }label: {
                    TrackRowView()
                }
                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                Button{
                    
                }label: {
                    TrackRowView()
                }
                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            .frame(height: UIScreen.main.bounds.height/2.2)
            Spacer()
        }
        .frame(width: .infinity)
        .padding(.top, 15)
    }
}

struct QueueVIew_Previews: PreviewProvider {
    static var previews: some View {
        QueueVIew()
    }
}
