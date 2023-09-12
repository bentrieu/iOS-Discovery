//
//  AddToPlayListSheet.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct AddToPlayListSheet: View {
    @Environment (\.dismiss) var dismiss
    @State var searchActive = false
    @State var searchResult = ""
    var body: some View {
        ZStack{
            Color("white")
                .ignoresSafeArea(.all)
            VStack(spacing: 30){
                //MARK: - HEADER
                HStack{
                    Button {
                        if searchActive{
                            withAnimation {
                                searchActive = false
                            }
                        }else{
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .modifier(Icon())
                            .frame(height: 16)
                            .rotationEffect(.degrees(searchActive ? 90 : 0), anchor: UnitPoint(x: 0.4, y: 0.15))
                    }
                    
                    
                    Spacer()
                    
                    if searchActive{
                        //MARK: - SEARCH BAR
                        SearchBarView(searchInput: $searchResult)
                    }else{
                        Text("Add To Playlist")
                            .font(.custom("Gotham-Bold", size: 22))
                            .modifier(BlackColor())
                            .offset(x: -7)
                        Spacer()
                    }
                }
                
                //MARK: - NEW PLAYLIST BUTTON
                Button{
                    
                }label: {
                    Text("New playlist")
                        .font(.custom("Gotham-Bold", size: 20))
                        .modifier(BlackColor())
                        .padding(.vertical)
                        .padding(.horizontal,30)
                        .background(
                            Capsule().stroke(Color("black"))
                        )
                }.opacity(searchActive ? 0 : 1)
                
                Spacer()
                
                
                HStack{
                    //MARK: - SEARCH PLAYLIST BUTTON
                    Button {
                        searchActive = true
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .modifier(Icon())
                                .frame(width: 20)
                                .bold()
                                .foregroundColor(Color("black"))
                            Text("Find playlist")
                                .font(.custom("Gotham-Medium", size: 20))
                                .modifier(BlackColor())
                        }
                        .frame(width: UIScreen.main.bounds.width/1.6, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(searchActive ? 0 : 0.4))
                        )
                    }
                    
                    Spacer()
                    
                    //MARK: - SORT BUTTON
                    Button {
                        
                    } label: {
                        Text("Sort")
                            .font(.custom("Gotham-Medium", size: 20))
                            .modifier(BlackColor())
                            .frame(width: UIScreen.main.bounds.width/4, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(searchActive ? 0 : 0.4))
                            )
                    }
                }
                .offset(y: searchActive ? -200 : 0)
                .opacity(searchActive ? 0 : 1)
                .animation(.easeOut(duration: 0.4), value: searchActive)
                
                
                
                //MARK: - PLAYLIST
                List{
                    
                }
                
                Spacer()
            }
            .padding(.horizontal, UIScreen.main.bounds.width/15)
            .padding(.vertical)
        }
    }
}

struct AddToPlayListSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddToPlayListSheet()
    }
}
