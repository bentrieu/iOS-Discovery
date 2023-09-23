////
////  TempProfileView.swift
////  Assignment3
////
////  Created by Ben Trieu on 16/09/2023.
////
//
//import SwiftUI
//import PhotosUI
//
//struct TempProfileView: View {
//    
//    @State var usernameText: String
//    
//    @StateObject private var viewModel = UserViewModel()
//    @Binding var showSignInView: Bool
//    
//    @State private var item: PhotosPickerItem? = nil
//    @State private var url: URL? = nil
//    
//    var body: some View {
//        List {
//            if let user = viewModel.user {
//                Group {
//                    Text("Userid: \(user.userId)")
//                    TextField("Username", text: $usernameText)
//                }
//                Button {
//                    viewModel.updateUserProfile(usernameText: usernameText)
//                } label: {
//                    Text("Save")
//                }
//                
//                if let email = user.email {
//                    Text("Email: \(email)")
//                }
//                if let date = user.dateCreated {
//                    Text("Date created  : \(date.description)")
//                }
//                
//                Button {
//                    Task {
//                        do {
//                            try await viewModel.addPlaylist()
//                        } catch {
//                            print(error)
//                        }
//                    }
//                } label: {
//                    Text("Add playlist")
//                }
//                
//                HStack {
//                    Button {
//                        Task {
//                            do {
//                                try await viewModel.addMusicToPlaylist(musicId: "1", playlistId: "v8AtiDouY7nv1napA7Uv")
//                            } catch {
//                                print(error)
//                            }
//                        }
//                    } label: {
//                        Text("Add music")
//                    }
//                    Button {
//                        Task {
//                            do {
//                                try await viewModel.addMusicToPlaylist(musicId: "2", playlistId: "v8AtiDouY7nv1napA7Uv")
//                            } catch {
//                                print(error)
//                            }
//                        }
//
//                    } label: {
//                        Text("Add music 2")
//                    }
//                    
//                    Button {
//                        Task {
//                            do {
//                                try await viewModel.removeMusicFromPlaylist(musicId: "1", playlistId: "v8AtiDouY7nv1napA7Uv")
//                            } catch {
//                                print(error)
//                            }
//                        }
//
//
//                    } label: {
//                        Text("remove music")
//                    }
//                    
//                    Button {
//                        Task {
//                            do {
//                                try await viewModel.removeMusicFromPlaylist(musicId: "2", playlistId: "v8AtiDouY7nv1napA7Uv")
//                            } catch {
//                                print(error)
//                            }
//                        }
//
//                    } label: {
//                        Text("remove music 2")
//                    }
//                }
//                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
//                    Text("select an image")
//                }
//                if let playlists = viewModel.playlists {
//                    List {
//                        ForEach(playlists, id:\.playlistId) { item in
//                            Text("\(item.playlistId)")
//                        }
//                    }
//                }
//                
//                if let urlString = viewModel.user?.profileImagePath, let url = URL(string: urlString) {
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 150, height: 150)
//                            .cornerRadius(10)
//                    } placeholder: {
//                        ProgressView()
//                            .frame(width: 150, height: 150)
//                    }
//                }
//            }
//        }
//        .onChange(of: item, perform: { newValue in
//            if let newValue {
//                viewModel.saveProfileImage(item: newValue)
//            }
//        })
//        .onAppear {
//            Task {
//                do {
//                    try? await viewModel.loadCurrentUser()
//                    try? await viewModel.loadUserPlaylist()
//                } catch {
//                    print(error)
//                }
//            }
//        }
//        .navigationTitle("Profile")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    TempSettingsView(showSignInView: $showSignInView)
//                } label: {
//                    Image(systemName: "gear")
//                        .font(.headline)
//                }
//            }
//        }
//    }
//}
//
//struct TempProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempProfileView(usernameText: "", showSignInView: .constant(false))
//    }
//}
