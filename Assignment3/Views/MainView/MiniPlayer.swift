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

struct MiniPlayer: View {
    @StateObject var musicManager = MusicManager.instance
    var animation : Namespace.ID
    @Binding var expand : Bool
    @State var pauseActive = false
    @State var shuffleActive = false
    @State var repeatActive = false
    @State var likeTrack = false
    @State var animatingHeart = false
    @State var viewQueue = false
    @State var showAddPlayListSheet = false
    @State var firstPlayMusic = true
    @State var offset : CGFloat = 0
    
    var height = UIScreen.main.bounds.height/3 + 20
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        VStack () {
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height : expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ?  safeArea?.top : 0)
                .padding(.vertical, expand ? 10 : 0)
            
            if expand{
                HStack{
                    Spacer()
                    //MARK: - VIEW QUEUE BUTTON
                    Button {
                        withAnimation {
                            viewQueue.toggle()
                        }
                    } label: {
                        Image(systemName: viewQueue ? "xmark" : "text.line.first.and.arrowtriangle.forward")
                            .resizable()
                            .renderingMode(.template)
                            .modifier(Icon())
                            .frame(height: 30)
                    }
                }.padding(.horizontal, 40)
                if !viewQueue{
                    Spacer(minLength: 60)
                }
            }
            
            VStack {
                HStack(spacing: 15){
                    
                    if expand{Spacer(minLength: 0)}
                    
                    if viewQueue{
                        QueueVIew()
                            .frame(height: UIScreen.main.bounds.height/1.7)
                    }else{
                        //MARK: - THUMBNAIL IMAGE
                        AsyncImage(url: URL(string: musicManager.currPlaying.imageUrl!)){ image in
                            image
                                .resizable()
                                .frame(width: expand ? height : 55, height: expand ? height : 55)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }placeholder: {
                            
                        }
                        
                    }
                    
                    if !expand{
                        VStack(alignment: .leading, spacing: 5) {
                            Text(musicManager.currPlaying.musicName!)
                                .font(Font.custom("Gotham-Medium", size: 16))
                                .foregroundColor(Color("black"))
                                .tracking(-1)
                            
                            Text(musicManager.currPlaying.artistName!)
                                .font(Font.custom("Gotham-Medium", size: 13))
                                .foregroundColor(Color("black").opacity(0.6))
                                .tracking(-1)
                        }
                    }
                    Spacer(minLength: 0)
                    if !expand{
                        Button {
                            MusicManager.instance.pauseMusic()
                        } label: {
                            Image(systemName:  !musicManager.isPlaying ? "play.circle" : "pause.circle")
                                .font(.title)
                                .foregroundColor(Color("black"))
                        }
                        
                        Button {
                            musicManager.currPlaying = musicManager.playNextMusic()!
                            musicManager.play()
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                                .foregroundColor(Color("black"))
                        }
                    }
                    
                }
                .padding(.horizontal)
                
                if !expand{
                    ProgressView(value: Double(musicManager.secondsElapsed) / Double(musicManager.currPlaying.musicLength!))
                        .padding(.horizontal)
                }
            }
            
            VStack {
                Spacer()
                if !viewQueue{
                    HStack{
                        VStack{
                            //MARK: - TRACK'S NAME
                            Text(musicManager.currPlaying.musicName!)
                                .font(.custom("Gotham-Bold", size: 28))
                                .modifier(OneLineText())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            //MARK: - ARTISTS
                            Text(musicManager.currPlaying.artistName!)
                                .font(.custom("Gotham-Book", size: 20))
                                .modifier(OneLineText())
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        //MARK: - HEART BUTTON
                        Button {
                            withAnimation {
                                animatingHeart = true
                            }
                            likeTrack.toggle()
                            withAnimation {
                                animatingHeart = false
                            }
                        } label: {
                            HeartButtonView(active: $likeTrack, startAnimation: animatingHeart)
                        }
                        //MARK: - ADD TO PLAYLIST BUTTON
                        Button {
                            showAddPlayListSheet = true
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color("black"))
                                .frame(height: 30)
                        }.fullScreenCover(isPresented: $showAddPlayListSheet) {
                            AddToPlaylistView()
                            
                        }
                    }
                }
                
                //MARK: - PROGRESS BAR
                ProgressView(value: Double(musicManager.secondsElapsed) / Double(musicManager.currPlaying.musicLength!))
                    .padding(.horizontal)
                
                //MARK: - START & END TIME
                HStack{
                    Text("\(musicManager.formatTime(musicManager.secondsElapsed))")
                        .font(.custom("Gotham-Light", size: 16))
                        .modifier(BlackColor())
                    Spacer()
                    Text("- \(musicManager.formatTime(musicManager.secondsRemaining))")
                        .font(.custom("Gotham-Light", size: 15))
                        .modifier(BlackColor())
                }
                .padding(.horizontal, 5)
                
                
                
                //MARK: - CONTROL BUTTONS
                HStack(spacing: UIScreen.main.bounds.width/13){
                    //MARK: - SHUFFLE BUTTON
                    Button {
                        musicManager.isShuffle.toggle()
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(musicManager.isShuffle ? .accentColor : Color("black"))
                            .frame(width: 30)
                    }
                    //MARK: - BACKWARD BUTTON
                    Button {
                        musicManager.currPlaying = musicManager.playPreviousMusic()!
                        musicManager.play()
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 37)
                    }
                    //MARK: - PLAY/PAUSE BUTTON
                    Button {
                        MusicManager.instance.pauseMusic()
                    } label: {
                        Image(systemName:  !musicManager.isPlaying ? "play.circle" : "pause.circle")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 75)
                            .rotationEffect(.degrees(!musicManager.isPlaying ? 0 : -180))
                    }
                    //MARK: - FORWARD BUTTON
                    Button {
                        musicManager.currPlaying = musicManager.playNextMusic()!
                        musicManager.play()
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 37)
                    }
                    //MARK: - REPEAT BUTTON
                    Button {
                        musicManager.isRepeat.toggle()
                    } label: {
                        Image(systemName: "repeat")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(musicManager.isRepeat ? .accentColor : Color("black"))
                            .frame(width: 30)
                    }
                }
             
            }
            .padding(.horizontal)
            .frame(width: expand ? nil : 0 , height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
            
            if expand{
                Spacer(minLength: 50)
            }
        }
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                Divider()
            }
                .onTapGesture {
                    withAnimation(.spring()){expand = true }
                }
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        .edgesIgnoringSafeArea(.all)
    }
    
    func onChanged (value: DragGesture.Value){
        
        //only allowed when it's expanded
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
    }
    
    func onEnded (value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95,blendDuration: 0.95)){
            
            if value.translation.height > height{
                viewQueue = false
                expand = false
            }
            
            offset = 0
        }
        
    }
}
//
//struct MiniPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniPlayer(animation: <#Namespace.ID#>, expand: <#Binding<Bool>#>)
//    }
//}
