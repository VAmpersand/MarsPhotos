//
//  PhotoService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation
import Combine


enum Rover: String, CaseIterable {
    case opportunity, spirit, curiosity
}

class PhotoService {
    static func getManifest(from rover: Rover) -> AnyPublisher<PhotosResponse, APIServiceError> {
        let urlStr = "https://api.nasa.gov/mars-photos/api/v1/manifest/\(rover.rawValue)?api_key=\(Constants.apiKey)"

        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.networkError(description: "Failure URL")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return APIService.fetchData(request)
            .eraseToAnyPublisher()
    }
    
    static func getPhoto(from rover: Rover, for date: Date) -> AnyPublisher<PhotosResponse, APIServiceError> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateStr = dateFormatter.string(from: date)
        let urlStr = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover.rawValue)/photos?earth_date=\(dateStr)&api_key=\(Constants.apiKey)"

        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.networkError(description: "Failure URL")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return APIService.fetchData(request)
            .eraseToAnyPublisher()
    }
    
    static func getPhoto(from rover: Rover, for sol: Int) -> AnyPublisher<PhotosResponse, APIServiceError> {
        let urlStr =  "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover.rawValue)/photos?sol=\(sol)&api_key=\(Constants.apiKey)"

        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.networkError(description: "Failure URL")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return APIService.fetchData(request)
            .eraseToAnyPublisher()
    }
}
