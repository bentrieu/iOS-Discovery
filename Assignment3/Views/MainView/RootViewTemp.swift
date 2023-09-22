//
//  RootViewTemp.swift
//  Assignment3
//
//  Created by Phuoc Dinh Gia Huu on 15/09/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage:  "house.fill")
                        .foregroundColor(Color("black"))
                }
            DiscoveryView()
                .tabItem {
                    Label("Search", systemImage:  "magnifyingglass")
                        .foregroundColor(Color("black"))
                }
            
            SearchView()
                .tabItem {
                    VStack{
                        Label("Library", systemImage:  "books.vertical.fill")
                            .foregroundColor(Color("black"))
                    }
                   
                }
        }
        .navigationBarBackButtonHidden(true)
        .foregroundColor(Color("black"))
    }
}

struct RootViewTemp_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
