//
//  Playlist.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
