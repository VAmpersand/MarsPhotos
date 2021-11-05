//
//  NetworkServiceError.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case kingfisherError(String)
    case unknown
}
