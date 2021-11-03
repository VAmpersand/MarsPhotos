//
//  ManifestsResponse.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 02.11.2021.
//

import Foundation

struct ManifestsApiResponse: Codable {
    let photoManifest: Manifest
}

struct Manifest: Codable {
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [ManifestPhoto]
}

struct ManifestPhoto: Codable {
    let sol: Int
    let earthDate: String
    let totalPhotos: Int
    let cameras: [String]
}
