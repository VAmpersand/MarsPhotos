//
//  Decoder.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkServiceError> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .decodeError(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
