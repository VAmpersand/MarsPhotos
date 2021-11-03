//
//  NasaAPIService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 03.11.2021.
//

import Foundation
import Combine

protocol NasaAPIService {
    var apiSession: APIService {get}
    
    func getManifest(for rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError>
    func getPhoto(for date: Date, from rover: Rover) -> AnyPublisher<PhotosApiResponse, APIError>
    func getPhoto(for sol: Int, from rover: Rover) -> AnyPublisher<PhotosApiResponse, APIError>
}

extension NasaAPIService {
    func getManifest(for rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError> {
        return apiSession.request(with: NasaAPIEndpoint.manifests(rover: rover))
            .eraseToAnyPublisher()
    }
    
    func getPhoto(for date: Date, from rover: Rover) -> AnyPublisher<PhotosApiResponse, APIError> {
        return apiSession.request(with: NasaAPIEndpoint.photoForDate(date, rover: rover))
            .eraseToAnyPublisher()
    }
    
    func getPhoto(for sol: Int, from rover: Rover) -> AnyPublisher<PhotosApiResponse, APIError> {
        return apiSession.request(with: NasaAPIEndpoint.photoForSol(sol, rover: rover))
            .eraseToAnyPublisher()
    }
}
