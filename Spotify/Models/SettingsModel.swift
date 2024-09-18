//
//  SettingsModel.swift
//  Spotify
//
//  Created by Pavel Maal on 18.09.24.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
