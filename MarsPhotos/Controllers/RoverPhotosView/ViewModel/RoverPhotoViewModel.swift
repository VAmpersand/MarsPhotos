//
//  RoverPhotoViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import SwiftUI
import Combine
import Kingfisher

final class RoverPhotoViewModel: ObservableObject, NasaAPIService {
    var apiSession: APIService
    
    init(manifest: Manifest, apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.manifest = manifest
        
        subscribe()
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var manifest: Manifest
    @Published var photos: [Photo] = []
}

extension RoverPhotoViewModel {
    func subscribe() {
        
        $manifest
            .flatMap { [unowned self] (manifest: Manifest) -> AnyPublisher<PhotosApiResponse, APIError> in
                return self.getPhoto(for: manifest.maxSol, from: manifest.rover)
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error): print(error.localizedDescription)
                    case .finished: return
                    }
                },
                receiveValue: { [unowned self] response in
//                    response.photos.forEach { self.photos.append($0) }
                }
            )
            .store(in: &cancellable)
    }
}
