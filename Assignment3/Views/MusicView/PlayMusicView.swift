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

struct PlayMusicView: View {
    @Environment (\.dismiss) var dismiss
    
    @State var pauseActive = false
    @State var shuffleActive = false
    @State var repeatActive = false
    @State var likeTrack = false
    @State var animatingHeart = false
    @State var viewQueue = false
    @State var showAddPlayListSheet = false
    @State var firstPlayMusic = true
    @StateObject var musicManager  = MusicManager.instance

    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack{
                //MARK: - HEADER
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .modifier(Icon())
                            .frame(height: 16)
                    }
                    
                    Spacer()
                    Text(viewQueue ? "Queue" : "On Play")
                        .font(.custom(viewQueue ? "Gotham-Bold" : "Gotham-Book", size: viewQueue ? 25 : 20))
                        .modifier(BlackColor())
                        .offset(x: viewQueue ? -5 : 0)
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
                            .frame(height: 27)
                    }
                }
                
                Spacer()
                
                if viewQueue{
                    //MARK: - QUEUE VIEW
                   QueueVIew()
               
                }else{
                    //MARK: - THUMBNAIL IMAGE
                    AsyncImage(url: URL(string: musicManager.currPlaying.imageUrl!)){ image in
                        image
                            .resizable()
                            .modifier(Img())
                            .frame(width: UIScreen.main.bounds.width/1.14)
                            .frame(height: UIScreen.main.bounds.height/2.2)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                    }placeholder: {
                        
                    }
                        
                        
                    
                    Spacer()
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
                        
                    }.frame(width: .infinity)
                }
                
                
                
                //MARK: - PROGRESS BAR
                ProgressView(value: Double(musicManager.secondsElapsed) / Double(musicManager.currPlaying.musicLength!))
                if !viewQueue{
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
                    .frame(width: .infinity)
                    .padding(.horizontal, 5)
                }
                
                
                //MARK: - CONTROL BUTTONS
                HStack(spacing: UIScreen.main.bounds.width/13){
                    //MARK: - SHUFFLE BUTTON
                    Button {
                        shuffleActive.toggle()
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(shuffleActive ? .accentColor : Color("black"))
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

                        if (firstPlayMusic){
                            withAnimation {
                                musicManager.play()

                            }
                            firstPlayMusic = false
                        }else{
                            withAnimation {
                                MusicManager.instance.pauseMusic()
                            }
                        }
                        
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
                        repeatActive.toggle()
                    } label: {
                        Image(systemName: "repeat")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(repeatActive ? .accentColor : Color("black"))
                            .frame(width: 30)
                    }
                }.frame(width: .infinity)
            }
            .modifier(PagePadding())
        }
        . navigationBarBackButtonHidden(true)
    }
   
    
}

struct PlayMusicView_Previews: PreviewProvider {
    static var previews: some View {
        PlayMusicView()
            .onAppear{
                MusicManager.instance.currPlaying = sampleMusic
            }
    }
}
let sampleMusic = Music(musicId: "8eRvtX2V8goiU3Sy7JIr",
        musicName: "Truy Tim Bao Vat",
        imageUrl: "https://i.scdn.co/image/ab67616d0000b273e368556118fdcd985aa28019",
        artistName: "24K Right",
        file: "gs://assignment3-fcc04.appspot.com/music/X2Download.app - Truy Lùng Bảo Vật - 24k.Right ft. Sofia - Team B Ray _ Rap Việt 2023 [MV Lyrics] (128 kbps).mp3",
musicLength: 341)

