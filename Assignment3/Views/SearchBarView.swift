/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Minh Quan, Dinh Huu Gia Phuoc, Vu Gia An, Trieu Hoang Khang, Nguyen Tran Khang Duy
  ID: s3877969, s3878270, s3926888, s3878466, s3836280
  Created  date: 10/9/2023
  Last modified: 23/9/2023
  Acknowledgement:
https://rmit.instructure.com/courses/121597/pages/w9-whats-happening-this-week?module_item_id=5219569
https://rmit.instructure.com/courses/121597/pages/w10-whats-happening-this-week?module_item_id=5219571
*/

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
                .font(.custom("Gotham-Medium", size: 18))
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
