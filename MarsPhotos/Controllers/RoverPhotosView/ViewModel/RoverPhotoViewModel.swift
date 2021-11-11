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
    
    init(selectedRover: Rover, apiSession: APIService = APISession()) {
        self.selectedRover = selectedRover
        self.apiSession = apiSession
        
        subscribe()
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    private var rightColumnHeight: CGFloat = 0
    private var leftColumnHeight: CGFloat = 0
    
    @Published var selectedRover: Rover
    @Published var manifest: Manifest?
    @Published var rightColumnPhotos: [Photo] = []
    @Published var leftColumnPhotos: [Photo] = []
}

extension RoverPhotoViewModel {
    func subscribe() {
        
        $selectedRover
            .setFailureType(to: APIError.self)
            .flatMap { [unowned self] (rover: Rover) -> AnyPublisher<ManifestsApiResponse, APIError> in
                return self.getManifest(for: rover)
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished: return
                    }
                },
                receiveValue: { [unowned self] manifest in
                    self.manifest = manifest.photoManifest
                }
            )
            .store(in: &cancellable)
        
        $manifest
            .dropFirst()
            .setFailureType(to: APIError.self)
            .flatMap { [unowned self] (manifest: Manifest?) -> AnyPublisher<PhotosApiResponse, APIError> in
                guard let manifest = manifest else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
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
                    
                    DispatchQueue.main.async {
                        response.photos.enumerated().forEach { index, photo in
                            if let url = URL(string: photo.imgSrc) {
                                let resource = ImageResource(downloadURL: url, cacheKey: photo.imgSrc)
                                
                                KingfisherManager.shared.retrieveImage(with: resource) { result in
                                    switch result {
                                    case .success(let value):
                                        let imageSize = value.image.size
                                        let aspectRatio = imageSize.height / imageSize.width
                                        
                                        if self.leftColumnHeight <= self.rightColumnHeight {
                                            self.leftColumnPhotos.append(photo)
                                            self.leftColumnHeight += aspectRatio
                                            
                                        } else {
                                            self.rightColumnPhotos.append(photo)
                                            self.rightColumnHeight += aspectRatio
                                        }
                                        
                                    case .failure(let error):
                                        print("Error: ", error.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                    
                    print("final", self.leftColumnPhotos.count, self.rightColumnPhotos.count)
                }
            )
            .store(in: &cancellable)
    }
}
