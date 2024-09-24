//
//  Artist.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
