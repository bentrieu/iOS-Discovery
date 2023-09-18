//
//  testMusicView.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import SwiftUI

struct testMusicView: View {
    @StateObject var viewModel = MusicViewModel()
    var body: some View {
      
            Button("Click me") {
                print("Click")
                for music in viewModel.musics {
                    print("in func")
                    print(music)
                }
            }
        }
    
}

struct testMusicView_Previews: PreviewProvider {
    static var previews: some View {
        testMusicView()
    }
}
