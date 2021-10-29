//
//  APIService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation
import Combine

class APIService {
    
    struct Response<T> { 
        let value: T
        let response: URLResponse
    }
    
    static func fetchData(_ request: URLRequest) -> AnyPublisher<PhotosResponse, APIServiceError> {        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                .networkError(description: error.localizedDescription)
            }
            .flatMap { response in
                decode(response.data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
