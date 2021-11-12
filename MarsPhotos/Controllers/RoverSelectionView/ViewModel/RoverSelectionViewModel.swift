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
    func subscribe() {}
}
