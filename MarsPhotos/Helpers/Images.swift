//
//  Images.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import Foundation

struct Images {
    static func getShapesBg(for rover: Rover) -> String {
        "\(rover.rawValue)_shape_bg"
    }
    
    static func getBg(for rover: Rover) -> String {
        "\(rover.rawValue)_bg"
    }
}
