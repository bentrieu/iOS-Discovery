//
//  NewPlaylistView.swift
//  Assignment3
//
//  Created by DuyNguyen on 12/09/2023.
//

import SwiftUI

struct NewPlaylistView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showView: Bool
    
    @StateObject var playlistManager = PlaylistManager.instance
    
    @State var input = ""
    @State var showErrorNotification = false
    
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
                                    .frame(height: 1)
                                    .overlay(showErrorNotification ? Color.red : Color("black"))
                                Text("Please give your playlist a name")
                                    .font(.custom("Gotham-Medium", size: 15))
                                    .foregroundColor(.red)
                                    
                                    .opacity(showErrorNotification ? 1 : 0)
                            }
                                .offset(x: 0, y: 30)
                        )
                )
                .onChange(of: input) { newValue in
                    showErrorNotification = false
                }
            HStack{
                Spacer()
                //MARK: - CANCEL BUTTON
                Button{
                    
                    showView = false
                    dismiss()
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
                    if input.isEmpty{
                        showErrorNotification = true
                    }else{
                        Task{
                            //create new playlist on firestore
                            do{
                                try await playlistManager.addPlaylist(name: input)
                            }catch{
                                print(error)
                            }
                            //fetch change to local playlists array
                            do{
                                playlistManager.playlists = try await playlistManager.getAllPlaylist()
                            }catch {
                                print(error)
                            }
                        }
                        //dismiss view
                        showView = false
                        dismiss()
                    }
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
        .onChange(of: showView, perform: { newValue in
            if newValue{
                focusedField = .inputSearch
                
            }else{
                focusedField = nil
                input = ""
            }
        })
    }
}

struct NewPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaylistView(showView: .constant(true))
    }
}
