//
//  RoverSelectionViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import Foundation
import Combine

final class RoverSelectionViewModel: ObservableObject, NasaAPIService {
    var apiSession: APIService
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        
        subscribe()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var selectedRover: Rover = .opportunity
    @Published var photos: [Photo] = []
    @Published var manifest: ManifestsApiResponse?
    
}

extension RoverSelectionViewModel {
    func subscribe() {
        
        $selectedRover
            .dropFirst()
            .setFailureType(to: APIError.self)
            .flatMap { [unowned self] (rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError> in
                return self.getManifest(for: rover)
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error): print(error.localizedDescription)
                    case .finished: return
                    }
                },
                receiveValue: { [unowned self] manifest in
                    self.manifest = manifest
                    print(self.manifest)
                }
            )
            .store(in: &cancellable)
    }
}

extension Publisher {
  func genericError() -> AnyPublisher<Self.Output, APIError> {
    return self
      .mapError({ (error: Self.Failure) -> APIError in
          return APIError.unknown
      }).eraseToAnyPublisher()
  }
}
