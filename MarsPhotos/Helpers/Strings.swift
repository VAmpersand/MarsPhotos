//
//  Strings.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation

struct Strings {
    public static func getTitleFor(rover name: RoverName) -> String {
        switch name {
        case .opportunity: return "Opportunity"
        case .curiosity: return "Curiosity"
        case .spirit: return "Spirit"
        }
    }
}
