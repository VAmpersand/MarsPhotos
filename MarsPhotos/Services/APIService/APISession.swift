//
//  APISession.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation
import Combine

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}

struct APISession: APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError {_ in .decodingError}
                            .eraseToAnyPublisher()
                        
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                    
                }
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
