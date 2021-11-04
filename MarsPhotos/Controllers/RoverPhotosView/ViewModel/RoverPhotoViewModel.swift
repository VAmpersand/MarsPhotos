//
//  RoverPhotoViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import Foundation
import Combine

final class RoverPhotoViewModel: ObservableObject, NasaAPIService {
    var apiSession: APIService
    
    init(manifest: Manifest, apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.manifest = manifest
        
        subscribe()
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
                    self.photos = response.photos
                }
            )
            .store(in: &cancellable)
        
    }
}
