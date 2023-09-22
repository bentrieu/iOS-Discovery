//
//  GenreView.swift
//  Assignment3
//
//  Created by DuyNguyen on 18/09/2023.
//

import SwiftUI

struct GenreView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var musicManager = MusicManager.instance
    let genre: String
    let color: Color
   
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [color, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack{
                
                //MARK: - LIST OF TRACKS
                VStack {
                    ForEach(musicManager.musicList, id: \.musicId) { item in
                        NavigationLink {
                            PlayMusicView()
                                .onAppear{
                                    musicManager.currPlaying = item
                                
                                }
                               
                        } label: {
                            MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: item)
                        }
                    }
                }
            }
            .modifier(PagePadding())
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
      
        .toolbar{
            ToolbarItem (placement: .navigationBarLeading){
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .modifier(Icon())
                        .frame(width: 25)
                }
            }
            ToolbarItem (placement: .principal){
                //MARK: - GENRE NAME
                Text(genre)
                    .font(.custom("Gotham-Black", size: 30))
                    .modifier(BlackColor())
            }

        }
        
   
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(genre: "Hip-hop", color: .green)
    }
}
