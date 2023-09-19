//
//  HomeView.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 13/09/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
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
                        }
                        .padding()
                        
                        //MARK: RECENTLY PLAYED MUSIC
                  

                        //MARK: ALBUM MUSIC ROW VIEW
                        AlbumView()
                        
                    }
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
        HStack(spacing: 15){
            Text("Good Afternoon")
                .tracking(-1)
                .font(Font.custom("Gotham-Bold", size: 26))
            Spacer()
            
            NavigationLink {
                
            } label: {
                Image("clock")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("black"))
                    .frame(width: 24,height: 24 )
                    .bold()
                    
            }
            
            
            NavigationLink {
                SettingView(account: account)
                    .navigationTitle("Settings")
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("black"))
                    .frame(width: 24,height: 24 )
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
