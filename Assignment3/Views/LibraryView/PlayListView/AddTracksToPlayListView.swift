//
//  AddTracksToPlayListView.swift
//  Assignment3
//
//  Created by DuyNguyen on 15/09/2023.
//

import SwiftUI

struct AddTracksToPlayListView: View {
    
    @Binding var showView: Bool
    
    @State var searchInput = ""
    var body: some View {
        VStack(spacing: 20){
            //MARK: - HEADER
            HStack{
                Button {
                    showView = false
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .modifier(Icon())
                        .frame(width: 25)
                }
                
                
                Spacer()
                
                Text("Add to this playlist")
                    .font(.custom("Gotham-Bold", size: 22))
                    .modifier(BlackColor())
                    .offset(x: -10)
                Spacer()
            }.padding(.bottom, 10)
            
            //MARK: - SEARCH BAR
            SearchBarView(searchInput: $searchInput, prompt: "Search")
            
            //MARK: - TRACK LIST
            List{
                Button{
                    //remove focus on search bar when tap on other views
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    
                }label: {
                    HStack{
                        ListRowView(imgName: "testImg",imgDimens: 55, title: "Song Name", titleSize: 20, subTitle: "Artists", subTitleSize: 15)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 25)
                            .offset(x: -10)
                    }
                }
                .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                
            }
            .padding(.vertical)
            .padding(.horizontal,10)
            .listStyle(PlainListStyle())
            .background(
                Color(.gray).opacity(0.3)
            )
            .cornerRadius(15)
            
            Spacer()
        }.modifier(PagePadding())
    }
}

struct AddTracksToPlayListView_Previews: PreviewProvider {
    static var previews: some View {
        AddTracksToPlayListView(showView: .constant(true))
    }
}
