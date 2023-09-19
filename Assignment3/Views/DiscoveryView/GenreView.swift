//
//  GenreView.swift
//  Assignment3
//
//  Created by DuyNguyen on 18/09/2023.
//

import SwiftUI

struct GenreView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let genre: String
    let color: Color
    
//    //MARK: - BACK BUTTON
//    var btnBack : some View { Button(action: {
//        self.presentationMode.wrappedValue.dismiss()
//    }) {
//        Image(systemName: "arrow.backward")
//            .resizable()
//            .modifier(Icon())
//            .frame(width: 25)
//    }
//    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [color, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack{
                
                //MARK: - LIST OF TRACKS
                List{
                    Button{
                        
                    }label: {
//                        ListRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 23, subTitle: "Artists", subTitleSize: 20)
                    }
                    .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(PlainListStyle())
                .padding(.top, 20)
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
