//
//  SearchResult.swift
//  Spotify
//
//  Created by Pavel Maal on 30.10.24.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
