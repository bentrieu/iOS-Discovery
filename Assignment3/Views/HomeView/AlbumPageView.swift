//
//  AlbumPageView.swift
//  Assignment3
//
//  Created by DuyNguyen on 19/09/2023.
//

import SwiftUI
import MinimizableView
struct AlbumPageView: View {
    @ObservedObject var miniHandler: MinimizableViewHandler = MinimizableViewHandler()
    @State var miniViewBottomMargin: CGFloat = 0
    @GestureState var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var album : Album
    
    @State var playMusicAvtive = false
    @StateObject var musicManager  = MusicManager.instance
    @State private var currentMusic : Music = Music(musicId: "temp")
    @Namespace var namespace
    var numOfTracks : Int{
        return album.musicList.count
    }
    
    //MARK: - BACK BUTTON
    var btnBack : some View { Button(action: {
        
        self.presentationMode.wrappedValue.dismiss()
        
    }) {
        Image(systemName: "arrow.backward")
            .resizable()
            .modifier(Icon())
            .frame(width: 25)
    }
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            
                VStack(spacing: 30){
                    //MARK: - THUMBNAIL IMG
    //                AsyncImage(url: URL(string: album.imageUrl!)) { image in
    //                    image
    //                        .resizable()
    //                        .frame(height: UIScreen.main.bounds.width/1.5)
    //                        .scaledToFill()
    //                        .ignoresSafeArea(.all)
    //                        .padding(.bottom, -50)
    //                } placeholder: {
    //
    //                }

                    HStack{
                        VStack(alignment: .leading){
                            //MARK: - PLAYLIST NAME
                            Text(album.title!)
                                .font(.custom("Gotham-Black", size: 35))
                                .modifier(OneLineText())
                            Text("\(numOfTracks) track(s)")
                                .font(.custom("Gotham-Medium", size: 18))
                                .modifier(OneLineText())
                        }
                        Spacer()
                        //MARK: - PLAY BUTTON
                        Button {
                            playMusicAvtive.toggle()
                        } label: {
                            Image(systemName: playMusicAvtive ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, alignment: .center)
                                .foregroundColor(.accentColor)
                                .background(
                                    Circle()
                                        .fill(Color(.white))
                                )
                        }
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.gray)
                    
                    //MARK: - LIST OF TRACKS
                  
                    VStack {
                        ForEach(musicManager.musicList, id: \.musicId) { item in
//                            NavigationLink {
//                                PlayMusicView()
//
//                                    .onAppear{
//                                        musicManager.currPlaying = item
//                                    }
//
//                            } label: {
                            Button {
                                self.miniHandler.present()
                                currentMusic = item
                            } label: {
                                MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: item)
                            }
                         
//                            }
                        }
                    }
                    Spacer()
                }
                .modifier(PagePadding())

            
            
        }
        .minimizableView(content: {
            PlayMusicView(animationNamespaceId: self.namespace)
                .onAppear{
                    musicManager.currPlaying = currentMusic
                }
        }, compactView: {
            MusicRowView(imgDimens: 60, titleSize: 21, subTitleSize: 17, music: currentMusic)
        }, backgroundView: {
            self.backgroundView()
        }, dragOffset: $dragOffset, dragUpdating: { (value, state, transaction) in
            state = value.translation
            self.dragUpdated(value: value)
        } ,dragOnChanged: { (value) in
            // add some custom logic if needed
    },
        dragOnEnded: { (value) in
        self.dragOnEnded(value: value)
    }, minimizedBottomMargin: self.miniViewBottomMargin, settings: MiniSettings(minimizedHeight: 80))
    .environmentObject(self.miniHandler)

        .task{
            do {
                MusicManager.instance.musicList = try await MusicViewModel.shared.getMusicListFromAlbum(album.albumId)
                
            } catch {
                // Handle the error
                print("Error: \(error)")
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)
    }
    //MARK: MINIMIZE VIEW
    func backgroundView() -> some View {
         VStack(spacing: 0){
             BlurView(style: .systemChromeMaterial)
             if self.miniHandler.isMinimized {
                 Divider()
             }
         }.cornerRadius(self.miniHandler.isMinimized ? 0 : 20)
         .onTapGesture(perform: {
             if self.miniHandler.isMinimized {
                 self.miniHandler.expand()
                 //alternatively, override the default animation. self.miniHandler.expand(animation: Animation)
             }
         })
     }
    func dragUpdated(value: DragGesture.Value) {
        
        if self.miniHandler.isMinimized == false && value.translation.height > 0   { // expanded state
            
            self.miniHandler.draggedOffsetY = value.translation.height  // divide by a factor > 1 for more "inertia" if needed
            
        } else if self.miniHandler.isMinimized && value.translation.height < 0   {// minimized state
            self.miniHandler.draggedOffsetY = value.translation.height  // divide by a factor > 1 for more "inertia" if needed
            
        }
    }
    
    func dragOnEnded(value: DragGesture.Value) {
        
        if self.miniHandler.isMinimized == false && value.translation.height > 90  {
            self.miniHandler.minimize()

        } else if self.miniHandler.isMinimized &&  value.translation.height < -60 {
                  self.miniHandler.expand()
        }
       withAnimation(.spring()) {
            self.miniHandler.draggedOffsetY = 0
       }

    }
  
}

struct AlbumPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumPageView(album: albumSample)
        }
    }
}

let albumSample = Album(albumId: "JkoOm0jVQ81LKSF6HeOP",
                        title: "99%",
                        type: "Rap",
                        musicList: ["OusE6eoQy5b765gHbIQB ","lB3DFP1fKpgNjeRaeQit"])

