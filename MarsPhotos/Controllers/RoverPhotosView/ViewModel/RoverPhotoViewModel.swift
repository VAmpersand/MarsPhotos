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
    private var savedPhoto: [Photo] = []
    @Published private var photos: [Photo] = []
    @Published var leftColumn: [PhotoData] = []
    @Published var rightColumn: [PhotoData] = []
}

extension RoverPhotoViewModel {
    struct PhotoData {
        let image: Image
        let photo: Photo
    }
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
        
        $photos
           .flatMap { photos in
               photos
                   .publisher
                   .setFailureType(to: APIError.self)
           }
           .flatMap { photo -> AnyPublisher<PhotoData, APIError> in

              let url = URL(string: photo.imgSrc)!

               return URLSession.shared
                   .dataTaskPublisher(for: url)
                   .receive(on: DispatchQueue.main)
                   .compactMap { UIImage(data: $0.data) }
                   .mapError { return APIError.kingfisherError($0.localizedDescription) }
                   .map { PhotoData(image: Image(uiImage: $0), photo: photo) }
                   .eraseToAnyPublisher()
           }
           .collect()
           .eraseToAnyPublisher()
           .sink(
               receiveCompletion: { result in
                   switch result {
                   case .failure(let error): print(error.localizedDescription)
                   case .finished: return
                   }
               },
               receiveValue: { [unowned self] response in
                   print(response)
                   
                   self.leftColumn = response
               }
           )
           .store(in: &cancellable)
       
//        $photos
//            .flatMap { [unowned self] (photos: [Photo]) -> AnyPublisher<(leftColumn: [Photo], rightColumn: [Photo]), Never> in
//
//                photos.forEach { photo in
//                    if !savedPhoto.contains(where: { $0.id == photo.id }) {
//                        fetchImage(from: photo) { photoData in
//
//                            //                            guard let photo = photoData.photo else {
//                            //                                return Fail(error: .kingfisherError).eraseToAnyPublisher()
//                            //                            }
//
//                            savedPhoto.append(photoData.photo)
//                        }
//                    }
//                }
//
//                return Just((leftColumn: [], rightColumn: [])).eraseToAnyPublisher()
//            }
//            .sink(
//                receiveCompletion: { result in
//                    switch result {
//                    case .failure(let error): print(error.localizedDescription)
//                    case .finished: return
//                    }
//                },
//                receiveValue: { [unowned self] value in
//                    self.leftColumn = value.leftColumn
//                    self.rightColumn = value.rightColumn
//                }
//            )
//            .store(in: &cancellable)
    }
    
//    private func fetchImage(from photo: Photo, completion: @escaping (PhotoData) -> Void)  {
//        guard let url = URL(string: photo.imgSrc) else { return }
//
//        let resource = ImageResource(downloadURL: url)
//        KingfisherManager.shared.retrieveImage(with: resource,
//                                               options: nil,
//                                               progressBlock: nil) { result in
//            switch result {
//            case .success(let value):
//                completion(PhotoData(image: Image(uiImage: value.image), photo: photo))
//
//            case .failure(let error):
//                completion(PhotoData(image: nil, photo: photo))
//                print("Error retrieveImage: \(error.localizedDescription)")
//            }
//        }
//    }
}
