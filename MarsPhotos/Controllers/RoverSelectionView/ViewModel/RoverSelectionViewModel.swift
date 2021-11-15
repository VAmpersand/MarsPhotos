//
//  RoverSelectionViewModel.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import SwiftUI
import Combine

final class RoverSelectionViewModel: ObservableObject {
    
    init() {
        subscribe()
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    var cancellable: Set<AnyCancellable> = []

    @Published var selectedRover: Rover = .opportunity
    @Published var routeToSafariView = false
    @Published var routeToPhotosView = false
    @Published var routeToPhotosByDateView = false
}

extension RoverSelectionViewModel {
    func subscribe() {}
}
