//
//  testMusic.swift
//  Assignment3
//
//  Created by An Vu Gia on 18/09/2023.
//

import SwiftUI

struct testMusic: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Click me") {
            Task {
                do{
                    let data = try await MusicManager.instance.getMusic(musicId: "1")
                    print("\(data)")
                } catch {
                    print("Can't get music")
                }

            }
        }
    }
}

struct testMusic_Previews: PreviewProvider {
    static var previews: some View {
        testMusic()
    }
}
