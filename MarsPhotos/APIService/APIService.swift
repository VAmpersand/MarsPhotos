//
//  APIService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation
import Combine

enum RoverName: String {
    case curiosity, opportunity, spirit
}

class APIService {
    static let shared = APIService()
    
    private let apiKey = "eb0Q4TEg6PKMZTlKogsUBgxQWGHH1SrWEgqfQxP4"
    
    private func getUrlFrom(rover name: RoverName, for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        let dateStr = dateFormatter.string(from: date)
        return "https://api.nasa.gov/mars-photos/api/v1/rovers/\(name.rawValue)/photos?earth_date=\(dateStr)&api_key=\(apiKey)"
    }
    
    func fetchPhotoFrom(rover name: RoverName, for date: Date) -> AnyPublisher<RoverPhotos, Never> {
        let urlStr = getUrlFrom(rover: name, for: date)
        guard let url = URL(string: urlStr) else {
            return Just(.error).eraseToAnyPublisher()
        }
    }
}
