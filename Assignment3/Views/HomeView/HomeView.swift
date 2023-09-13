//
//  HomeView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color("white")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading,spacing: 10){
                    HeadingView()
                    
                    
                    HStack{
                        
                        Button {
                            
                        } label: {
                            CustomButton(name: "Music")
                        }

                        
                        Button {
                            
                        } label: {
                            CustomButton(name: "Podcast & Shows")
                        }
                      
                      
                    }
                    .padding()
                    RowForSquareView(title: "Recently Played", itemList: bigSquareDataArray, size: 110) {
                        HStack{
                            Text("Top 50 - Viet Nam")
                                .font(Font.custom("Gotham-Medium", size: 16))
                                .frame(width: 100,alignment: .leading)
                                .foregroundColor(Color("black"))
                            
                        }
                        
                    }
                    
                    
                    
                    RowForSquareView(title: "Uniquely yours", itemList: bigSquareDataArray, size: 175) {
                        HStack{
                            Text("Song you love right now")
                                .font(Font.custom("Gotham-Medium", size: 16))
                                .frame(width: 175,alignment: .leading)
                                .foregroundColor(Color("black").opacity(0.4))
                            
                        }
                        
                    }
                    
                    RowForSquareView(title: "Trending now near you", itemList: bigSquareDataArray, size: 175) {
                        HStack{
//                            TextForAlbumView(title: <#T##String#>, type: <#T##String#>, name: <#T##String#>, size: <#T##CGFloat#>)
                            
                        }
                        
                    }
                    
                    RowForSquareView(title: "Popular Radio", itemList: bigSquareDataArray, size: 175) {}
                    
                }
            }
           
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HeadingView: View {
    var body: some View {
        HStack{
            Text("Good Afternoon")
                .tracking(-1)
                .font(Font.custom("Gotham-Bold", size: 26))
            Spacer()
            
            Button {
                
            } label: {
                Image("clock")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("black"))
                    .frame(width: 25,height: 25)
                    .bold()
                    
            }
        }
        .padding(.horizontal)
    }
}



struct CustomButton: View {
    var name : String
    var body: some View {
        Text(name)
            .font(Font.custom("Gotham-Medium", size: 16))
            .foregroundColor(Color("black"))
            .padding(.horizontal)
            .padding(.vertical,5)
            .background(Color("gray").opacity(0.4))
            .clipShape(Capsule())
    }
}
