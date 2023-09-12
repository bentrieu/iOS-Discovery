//
//  NewPlaylistView.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct NewPlaylistView: View {
    @Binding var addNewPlaylist: Bool
    @State var input = ""
    
    enum FocusedField {
        case inputSearch
    }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Text("Give your playlist a name")
                .font(.custom("Gotham-Medium", size: 25))
                .modifier(OneLineText())
            TextField("", text: $input)
                .font(.custom("Gotham-Bold", size: 40))
                .modifier(BlackColor())
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .inputSearch)
                .background(
                    Color.clear
                        .overlay(
                            VStack{
                                Divider()
                                    .overlay(Color.gray)
                                    .offset(x: 0, y: 15)
                            }
                        )
                )
            HStack{
                Spacer()
                //MARK: - CANCEL BUTTON
                Button{
                    addNewPlaylist = false
                }label: {
                    Text("Cancel")
                        .font(.custom("Gotham-Medium", size: 20))
                        .modifier(BlackColor())
                        .padding(.vertical,20)
                        .frame(width: 130)
                        .background(
                            Capsule().stroke(Color("black"))
                        )
                }
                
                Spacer()
                
                //MARK: - CREATE BUTTON
                Button{
                    addNewPlaylist = false
                }label: {
                    Text("Create")
                        .font(.custom("Gotham-Bold", size: 20))
                        .modifier(BlackColor())
                        .padding(.vertical, 20)
                        .frame(width: 130)
                        .background(
                            Capsule().fill(Color.accentColor)
                        )
                }
                Spacer()
            }
        }
        .onChange(of: addNewPlaylist, perform: { newValue in
            if focusedField == .inputSearch{
                focusedField = nil
                input = ""
            }else{
                focusedField = .inputSearch
            }
        })
    }
}

struct NewPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaylistView(addNewPlaylist: .constant(true))
    }
}
