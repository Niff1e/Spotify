//
//  HapticsManager.swift
//  Spotify
//
//  Created by Pavel Maal on 3.09.24.
//

import Foundation
import UIKit

final class HapticksManager {
    static let shared = HapticksManager()
    
    private init() {}
    
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
