//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Pavel Maal on 5.11.24.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track, tracks.isEmpty {
            return track
        }
        else if !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    var playerVC: PlayerViewController?
    
    // MARK: - Start playing music methods
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
        
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()
    }
}

// MARK: - Player View Controller Delegate Methods

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didTapCloseButton() {
        if let player = player {
            player.pause()
            playerVC = nil
            self.track = nil
        } else if let player = playerQueue {
            player.pause()
            playerVC = nil
            self.tracks = []
            index = 0
        }
    }
    
    func didSlideSlider(to value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let _ = playerQueue {
            if index == tracks.count - 1 {
                index = 0
                playerQueue?.removeAllItems()
                
                let items = tracks.compactMap { track -> AVPlayerItem? in
                    guard let url = URL(string: track.preview_url ?? "") else {
                        return nil
                    }
                    return AVPlayerItem(url: url)
                }
                
                playerQueue = AVQueuePlayer(items: items)
                playerVC?.refreshUI()
                playerQueue?.play()
                playerQueue?.volume = 0.5
            } else {
                index += 1
                playerVC?.refreshUI()
                playerQueue?.advanceToNextItem()
            }
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else if let _ = playerQueue {
            if index == 0 {
                playerQueue?.removeAllItems()
                guard let lastTrack = self.tracks.popLast() else {
                    return
                }
                tracks.insert(lastTrack, at: 0)
                
            } else {
                index -= 1
            }
            let items = tracks.compactMap { track -> AVPlayerItem? in
                guard let url = URL(string: track.preview_url ?? "") else {
                    return nil
                }
                return AVPlayerItem(url: url)
            }
            playerVC?.refreshUI()
            
            playerQueue = AVQueuePlayer(items: items)
            playerQueue?.play()
            playerQueue?.volume = 0.5
            
        }
    }
}

// MARK: - Player Data Source Methods

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
