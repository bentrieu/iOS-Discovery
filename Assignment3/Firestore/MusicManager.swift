//
//  MusicManager.swift
//  Assignment3
//
//  Created by Ben Trieu on 18/09/2023.
//

import Foundation
import FirebaseStorage
import AVFoundation
final class MusicManager : ObservableObject {
    
    static let instance = MusicManager()
    private init() {}
    
    var player: AVPlayer?
    
    @Published var isPlaying = false
    
    @Published var musicList = [Music]()
    
    @Published var currPlaying : Music = sampleMusic
    
    @Published var secondsElapsed = 0{
        didSet{
            secondsRemaining -= 1
        }
    }
    /// The number of seconds until all attendees have had a turn to speak.
    @Published var secondsRemaining = 0
    
   
    
    private var timer: Timer?

    func playMusicById(id: String) {
        Task {
            do {
                if let music = try await MusicViewModel.shared.findMusicById(id) {
                    let storage = Storage.storage().reference(forURL: music.file!)
                    do {
                        let url = try await storage.downloadURL()
                        print(url.absoluteString)
                        self.player = AVPlayer(playerItem: AVPlayerItem(url: url))
                        self.player?.play()
                    } catch {
                        print("Error downloading music URL: \(error.localizedDescription)")
                    }
                } else {
                    // Handle the case where no document with the specified musicId exists
                    print("No music found for the specified ID")
                }
            } catch {
                // Handle the error from findMusicById
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func reset(music: Music){
        self.secondsElapsed = 0
        self.secondsRemaining = music.musicLength!
        self.isPlaying = false
    }

    func pauseMusic(){
        self.isPlaying.toggle()
        if isPlaying{
            self.player?.play()
            self.startTimer()
            return
        }
        self.stopTimer()
        self.player?.pause()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.secondsElapsed += 1
            
            if(self.secondsElapsed == self.currPlaying.musicLength){
                self.currPlaying = self.playNextMusic()!
                self.play()
            }
            
        }
    }
    func stopTimer() {
            timer?.invalidate()
            timer = nil
    }
    
    func playNextMusic() -> Music? {
        guard let currentIndex = self.musicList.firstIndex(where: { $0.musicId == currPlaying.musicId }) else {
            // Current music not found in the list
            return nil
        }

        let nextIndex = (currentIndex + 1) % self.musicList.count
        return self.musicList[nextIndex]
    }
    
    func playPreviousMusic() -> Music? {
        guard let currentIndex = self.musicList.firstIndex(where: { $0.musicId == currPlaying.musicId }) else {
            // Current music not found in the list
            return nil
        }

        let previousIndex = (currentIndex - 1 + self.musicList.count) % self.musicList.count
        return self.musicList[previousIndex]
    }
    
    func searchMusicByGenre(_ genre: Genre){
        self.musicList = MusicViewModel.shared.musics.filter { $0.genre!.contains(genre.rawValue) }
    }
    
    func play(){
        self.playMusicById(id: self.currPlaying.musicId)
        self.reset(music: self.currPlaying)
        self.startTimer()
        self.isPlaying = true
    }

}
