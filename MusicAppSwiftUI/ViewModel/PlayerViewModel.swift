//
//  PlayerViewModel.swift
//  MusicAppSwiftUI
//
//  Created by   ST on 4/4/23.
//


import Foundation
import AVFAudio
import AVFoundation
import UIKit

class PlayerViewModel {
    var song: Song
    var player: AVPlayer?
    var isPlaying = false
    var timeObserverToken: Any?
    var cachedImage: UIImage!
    
    
    init(song: Song, cachedImage: UIImage? = nil) {
        self.song = song
        self.cachedImage = cachedImage
        print("init player view model")
    }
    

    func play(){
        if player == nil {
            guard let previewURL = URL(string: song.previewURL!) else {
                print("no valid preview url")
                return
            }
            let playerItem = AVPlayerItem(url: previewURL)
            self.player = AVPlayer(playerItem: playerItem)
        }
        player?.play()
        isPlaying = true
    }
    
    func pause() {
            player?.pause()
            isPlaying = false
        }
    
    func getDuration() async -> CMTime {
        guard let urlString = song.previewURL, let url = URL(string: urlString) else {
            return .zero
        }

        let asset = AVURLAsset(url: url)
        do {
            let duration = try await asset.load(.duration)
            return duration
        } catch {
            print("Failed to load duration: \(error.localizedDescription)")
            return .zero
        }
    }


    
    private var durationObserver: NSKeyValueObservation?

    func getDuration(completion: @escaping (CMTime?) -> Void) {
        durationObserver = player?.currentItem?.observe(\.duration, options: [.new, .initial]) { [weak self] (playerItem, _) in
            if playerItem.status == .readyToPlay {
                completion(playerItem.duration)
                self?.durationObserver = nil
            }
        }
    }

    func getCurrentTime() -> CMTime? {
            return player?.currentTime()
        }
    
    func seek(to time: CMTime) {
            player?.seek(to: time)
        player?.play()
        isPlaying = true
        }
    
    deinit {
        print("deinit player view model")
    }
}

