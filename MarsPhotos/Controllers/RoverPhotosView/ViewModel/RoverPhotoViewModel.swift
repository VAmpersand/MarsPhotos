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
    
    init(manifests: Manifest, apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.manifest = manifests
        
        subscribe()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var photos: [Photo] = []
    @Published var manifest: Manifest
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
        
        
//        $selectedRover
//            .dropFirst()
//            .setFailureType(to: APIError.self)
//            .flatMap { [unowned self] (rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError> in
//                return self.getManifest(for: rover)
//            }
//            .sink(
//                receiveCompletion: { result in
//                    switch result {
//                    case .failure(let error): print(error.localizedDescription)
//                    case .finished: return
//                    }
//                },
//                receiveValue: { [unowned self] manifest in
//                    self.manifest = manifest
//                }
//            )
//            .store(in: &cancellable)
        
    }
}
