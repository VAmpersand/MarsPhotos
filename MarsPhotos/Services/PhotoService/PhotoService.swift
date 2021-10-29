//
//  PhotoService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation
import Combine


enum RoverName: String, CaseIterable {
    case opportunity, spirit, curiosity
}

class PhotoService {
    static func getPhotoFrom(rover name: RoverName, for date: Date) -> AnyPublisher<PhotosResponse, APIServiceError> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateStr = dateFormatter.string(from: date)
        let urlStr = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(name.rawValue)/photos?earth_date=\(dateStr)&api_key=\(Constants.apiKey)"

        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.networkError(description: "Failure URL")).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return APIService.fetchData(request)
            .eraseToAnyPublisher()
    }

}
