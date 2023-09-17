//
//  SearchBarView.swift
//  Assignment3
//
//  Created by DuyNguyen on 15/09/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchInput:String
    let prompt: String
    
    var body: some View {
        HStack{
            //MARK: - SEARCH ICON
            Image(systemName: "magnifyingglass")
                .resizable()
                .modifier(Icon())
                .frame(width: 20)
                .bold()
                .foregroundColor(Color("black"))
            //MARK: - INPUT FIELD
            TextField("", text: $searchInput, prompt: Text(prompt)
                .font(.custom("Gotham-Medium", size: 20))
                .foregroundColor(Color("black")))
            .foregroundColor(Color("black"))
            .font(.custom("Gotham-Medium", size: 20))
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)

            //MARK: - X MARK TO DELETE WHOLE INPUT FIELD
            Image(systemName: "xmark")
                .resizable()
                .modifier(Icon())
                .frame(width: 18)
                .bold()
                .opacity(searchInput.isEmpty ? 0.0 : 1.0) // x mark appreas when there is input
                .onTapGesture {
                    searchInput = ""
                }
        }
        .padding(.horizontal)
        .frame(height: 45)

        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.5))
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchInput: .constant(""), prompt: "Find Playlist")
    }
}
