//
//  testMusic.swift
//  Assignment3
//
//  Created by Hữu Phước  on 19/09/2023.
//

import SwiftUI
import AVFAudio

struct testMusic: View {
    
    var body: some View {
        VStack{
            Button("Click Me ") {
                AlbumManager.shared.fetchPopularAlbumList { result, error in
                    print(result)
                }
            }
            Button("Stop") {
                MusicManager.instance.pauseMusic()
            }
        }
    }
}

struct testMusic_Previews: PreviewProvider {
    static var previews: some View {
        testMusic()
    }
}
