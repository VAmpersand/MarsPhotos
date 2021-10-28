//
//  RoverPhotos.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation

enum Response: Codable {
    case error(String)
    case photos([RoverPhotos])
    
    private enum CodingKeys: String, CodingKey {
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let payload = try? container.decode([RoverPhotos].self, forKey: .photos)
        self = payload.map { .photos($0) } ?? .error("Decoding error")
    }
}

struct RoverPhotos: Codable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
}

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
}
