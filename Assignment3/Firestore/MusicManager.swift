//
//  MusicManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 18/09/2023.
//

import Foundation
import FirebaseStorage
import AVFoundation
final class MusicManager {
    
    static let instance = MusicManager()
    private init() {}
    
    var player: AVPlayer?
    
    @Published var isPlaying = true
    
    
    func playMusicById(id: String) {
        //get storage service
        MusicViewModel.shared.findMusicById(id) { result in
            switch result {
                case .success(let music):
                    if let music = music {
                        // You have a valid Music object here
                        // You can use the 'music' variable for further processing
                        let storage = Storage.storage().reference(forURL: music.file!)
                        storage.downloadURL { (url, error) in
                            if error != nil{
                                print (error)
                            }else{
                                print(url?.absoluteString)
                                self.player = AVPlayer(playerItem: AVPlayerItem(url: url!))
                                self.player?.play()
                            }
                        }
                        
                    } else {
                        // Handle the case where no document with the specified musicId exists
                        print("No music found for the specified ID")
                    }
                case .failure(let error):
                    // Handle the error here
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    func pauseMusic(){
        self.isPlaying.toggle()
        if isPlaying{
            self.player?.play()
            return
        }
        self.player?.pause()
    }
}
