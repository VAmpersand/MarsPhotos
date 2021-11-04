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
    var router: RoutingService
    
    init(apiSession: APIService = APISession(), router: RoutingService = AppRouter()) {
        self.apiSession = apiSession
        self.router = router
        
        subscribe()
    }
    
    var cancellable: Set<AnyCancellable> = []

    @Published var selectedRover: Rover = .opportunity
    @Published var manifest: Manifest?
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
                    self.manifest = manifest.photoManifest
                }
            )
            .store(in: &cancellable)
        
//        $manifest
//            .sink(
//               receiveValue: { [unowned self] manifest in
//                   guard let manifest = manifest else { return }
//                   
////                   self.appRouter.state = .roverPhotosView(manifest: manifest)
////                   self.routingService.routeToRoverPhotos(manifest: manifest)
//                }
//            )
//            .store(in: &cancellable)
        
        //            .flatMap { [unowned self] (manifest: Manifest?) -> () in
//
//            }
//            .flatMap { [unowned self] (manifest: ManifestsApiResponse?) -> AnyPublisher<PhotosApiResponse, APIError> in
//                guard let sol = manifest?.photoManifest.maxSol,
//                      let rover = Rover(rawValue: manifest?.photoManifest.name ?? "") else {
//                          return Fail(error: APIError.unknown).eraseToAnyPublisher()
//                      }
//
//                return self.getPhoto(for: sol, from: rover)
//            }
    }
}
