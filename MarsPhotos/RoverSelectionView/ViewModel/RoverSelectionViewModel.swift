//
//  RoverSelectionViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import Foundation
import Combine

final class RoverSelectionViewModel: ObservableObject {
    
    private var cancellable: Set<AnyCancellable> = []
    
    @Published var currentRover: RoverName = .opportunity
    @Published var photos: [Photo] = []
    
    init() {
        subscribe()
    }
}

extension RoverSelectionViewModel {
    func subscribe() {
        let date = Date(timeInterval: -2*86400, since: Date())
        
        $currentRover
            .dropFirst()
            .removeDuplicates()
            .flatMap { (name: RoverName) -> AnyPublisher<PhotosResponse, APIServiceError> in
                PhotoService.getPhotoFrom(rover: name, for: date)
            }
            .sink(
                receiveCompletion: { [weak self] result in
                    guard let self = self else { return }
                    
                    switch result {
                    case .failure: self.photos = []
                    case .finished: break
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    
                    self.photos = response.photos
                }
            )
            .store(in: &cancellable)
    }
}
