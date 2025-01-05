//
//  LibraryPlaylistResponse.swift
//  Spotify
//
//  Created by Pavel Maal on 8.12.24.
//

import Foundation

struct LibraryPlaylistResponse: Codable {
    let items: [LibraryPlaylist]
}

struct LibraryPlaylist: Codable {
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]?
    let name: String
    let owner: User
}
