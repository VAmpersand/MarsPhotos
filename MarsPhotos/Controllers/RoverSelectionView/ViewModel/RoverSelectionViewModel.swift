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
    
    @Published var currentRover: Rover = .opportunity
    @Published var photos: [Photo] = []
    @Published var manifest: ManifestsApiResponse?
    
    init() {
        subscribe()
    }
}

extension RoverSelectionViewModel {
    func subscribe() {
        let date = Date(timeInterval: -2 * 86400, since: Date())
        
        $currentRover
            .dropFirst()
            .removeDuplicates()
            .map { (rover: Rover) -> () in
                //                APIService.getPhoto(from: rover, for: date)
//
                
//                APIService.getManifests(from: .curiosity) { (result: Result<ManifestsResponse, NetworkServiceError>) in
//                    switch result {
//                    case .success(let result):
//                        self.manifest = result
//                        print(self.manifest)
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//
                print(rover)
            }

//            .sink(receiveCompletion: { [weak self] result in
//                    guard let self = self else { return }
//
//                    switch result {
//                    case .failure: self.photos = []
//                    case .finished: break
//                    }
//                },
//                  receiveValue: { [weak self] response in
//                guard let self = self else { return }
//                
//                self.manifest = response
//            }
            
//            .store(in: &cancellable)
    }
}
