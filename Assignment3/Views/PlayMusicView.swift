//
//  PlayMusicView.swift
//  Assignment3
//
//  Created by DuyNguyen on 11/09/2023.
//

import SwiftUI

struct PlayMusicView: View {
    @State var pauseActive = false
    @State var shuffleActive = false
    @State var repeatActive = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color("white")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack{
                //MARK: - HEADER
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .modifier(Icon())
                        
                            .frame(height: 16)
                    }
                    
                    Spacer()
                    Text("On Play")
                        .font(.custom("Gotham-Book", size: 20))
                        .modifier(BlackColor())
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .modifier(Icon())
                            .frame(height: 6)
                            .bold()
                            .rotationEffect(.degrees(90))
                    }


                }
                
                Spacer()
                
                //MARK: - THUMBNAIL IMAGE
                Image("testImg")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height/2.2)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                
                //MARK: - TRACK'S NAME
                Text("Song Name")
                    .font(.custom("Gotham-Bold", size: 25))
                    .modifier(BlackColor())
                    .frame(maxWidth: .infinity, alignment: .leading)
                //MARK: - ARTISTS
                Text("Artists")
                    .font(.custom("Gotham-Book", size: 18))
                    .modifier(BlackColor())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                //MARK: - PROGRESS BAR
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.black.opacity(0.08))
                        .frame(height: 8)
                    
                    Capsule()
                        .modifier(BlackColor())
                        .frame(width: 200,height: 8)
                }.frame(width: .infinity)
                
                //MARK: - START & END TIME
                HStack{
                    Text("0:00")
                        .font(.custom("Gotham-Light", size: 16))
                        .modifier(BlackColor())
                    Spacer()
                    Text("0:00")
                        .font(.custom("Gotham-Light", size: 15))
                        .modifier(BlackColor())
                }
                .frame(width: .infinity)
                .padding(.horizontal, 5)
                
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
                        
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 35)
                    }
                    //MARK: - PLAY/PAUSE BUTTON
                    Button {
                        withAnimation {
                            pauseActive.toggle()
                        }
                    } label: {
                        Image(systemName: pauseActive ? "play.circle" : "pause.circle")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 70)
                            .rotationEffect(.degrees(pauseActive ? 0 : -180))
                    }
                    //MARK: - FORWARD BUTTON
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .resizable()
                            .modifier(Icon())
                            .frame(width: 35)
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
            .padding(.horizontal, UIScreen.main.bounds.width/15)
            .padding(.vertical)
        }
    }
}

struct PlayMusicView_Previews: PreviewProvider {
    static var previews: some View {
        PlayMusicView()
    }
}

