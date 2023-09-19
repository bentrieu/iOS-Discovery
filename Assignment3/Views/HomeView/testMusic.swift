//
//  testMusic.swift
//  Assignment3
//
//  Created by Hữu Phước  on 19/09/2023.
//

import SwiftUI
import AVFAudio

struct testMusic: View {
    @StateObject var musicManager = MusicManager.instance
    var body: some View {
        VStack{
            Text("\(musicManager.formatTime( musicManager.secondsElapsed)    )")
            Button("Click Me ") {
                musicManager.startTimer()
            }
            Button("Stop") {
                musicManager.stopTimer()
            }
        }
    }
}

struct testMusic_Previews: PreviewProvider {
    static var previews: some View {
        testMusic()
    }
}
