//
//  RoverPhotoResponse.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation

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
    let roverId: String
    let fullName: String
}

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
}
