//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Pavel Maal on 10.01.25.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [LibraryAlbum]
}

struct LibraryAlbum: Codable {
    let album: Album
}
