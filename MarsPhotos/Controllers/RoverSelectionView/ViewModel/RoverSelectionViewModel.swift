//
//  RoverSelectionViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import SwiftUI
import Combine

final class RoverSelectionViewModel: ObservableObject, NasaAPIService {
    var apiSession: APIService
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession

        subscribe()
    }
    
    var cancellable: Set<AnyCancellable> = []

    @Published var selectedRover: Rover = .opportunity
    @Published var manifest: Manifest?
    @Published var routeToPhotosView = false
}

extension RoverSelectionViewModel {
    func subscribe() {
        
//        $selectedRover
//            .dropFirst()
//            .setFailureType(to: APIError.self)
//            .flatMap { [unowned self] (rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError> in
//                return self.getManifest(for: rover)
//            }
//            .sink(
//                receiveCompletion: { result in
//                    switch result {
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    case .finished: return
//                    }
//                },
//                receiveValue: { [unowned self] manifest in
//                    self.routeToPhotosView = true
//                    self.manifest = manifest.photoManifest
//                }
//            )
//            .store(in: &cancellable)
    }
}
