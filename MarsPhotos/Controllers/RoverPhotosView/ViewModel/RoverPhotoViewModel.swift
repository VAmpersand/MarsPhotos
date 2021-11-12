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
    
    init(rover: Rover, apiSession: APIService = APISession()) {
        self.rover = rover
        self.apiSession = apiSession
        
        subscribe()
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    private var rightColumnHeight: CGFloat = 0
    private var leftColumnHeight: CGFloat = 0
    
    private var sol: Int = 0
    private var page: Int = 1
    private var perPage: Int = 25
    private var isNeedLoadNextPage = false

    @Published var rover: Rover
    @Published var manifest: Manifest?
    @Published var rightColumnPhotos: [Photo] = []
    @Published var leftColumnPhotos: [Photo] = []
    @Published var loadMorePhoto: Void = ()
    @Published var inLoading = false
}

extension RoverPhotoViewModel {
    func subscribe() {
        
        $rover
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
                self.inLoading = true
                self.sol = manifest.maxSol
                return self.getPhoto(for: self.sol, from: self.rover, page: self.page)
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error): print(error.localizedDescription)
                    case .finished: return
                    }
                },
                receiveValue: { [unowned self] response in
                    self.inLoading = false
                    self.isNeedLoadNextPage = !(response.photos.count < self.perPage)
                    
                    DispatchQueue.global().async {
                        response.photos.forEach { photo in
                            self.loadPhoto(by: photo)
                        }
                    }
                }
            )
            .store(in: &cancellable)
        
        $loadMorePhoto
            .dropFirst()
            .setFailureType(to: APIError.self)
            .flatMap { [unowned self] _ -> AnyPublisher<PhotosApiResponse, APIError> in
                
                if isNeedLoadNextPage {
                    self.page += 1
                } else {
                    self.page = 1
                    self.sol -= 1
                }
                
                self.inLoading = true
                return self.getPhoto(for: self.sol, from: self.rover, page: self.page)
            }
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error): print(error.localizedDescription)
                    case .finished: return
                    }
                },
                receiveValue: { [unowned self] response in
                    self.inLoading = false
                    self.isNeedLoadNextPage = !(response.photos.count < self.perPage)
                    
                    DispatchQueue.global().async {
                        response.photos.forEach { photo in
                            self.loadPhoto(by: photo)
                        }
                    }
                }
            )
            .store(in: &cancellable)
    }
}

private extension RoverPhotoViewModel {
    func loadPhoto(by photo: Photo) {
        if let url = URL(string: photo.imgSrc) {
            let resource = ImageResource(downloadURL: url, cacheKey: photo.imgSrc)
            
            KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        let imageSize = value.image.size
                        let aspectRatio = imageSize.height / imageSize.width
                        
                        if self.leftColumnHeight <= self.rightColumnHeight {
                            self.leftColumnPhotos.append(photo)
                            self.leftColumnHeight += aspectRatio
                            
                        } else {
                            self.rightColumnPhotos.append(photo)
                            self.rightColumnHeight += aspectRatio
                        }
                    }
                    
                case .failure(let error):
                    print("Error: ", error.localizedDescription)
                }
            }
        }
    }
}
