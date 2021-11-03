//
//  NetworkService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import Foundation
import Combine

class NetworkService {
    
   static var shared = NetworkService()
    
    struct Response<T> { 
        let value: T
        let response: URLResponse
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    static func fetchData(_ request: URLRequest) -> AnyPublisher<PhotosResponse, NetworkServiceError> {        
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
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkServiceError>) -> Void)  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    completion(.failure(.networkError(description: error.localizedDescription)))
                case .finished:
                    return
                }
            } receiveValue: { result in
                completion(.success(result))
            }
            .store(in: &cancellable)
    }
    
}
