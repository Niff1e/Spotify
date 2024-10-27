//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Pavel Maal on 27.10.24.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
