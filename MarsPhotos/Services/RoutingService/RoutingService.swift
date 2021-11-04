//
//  RoutingService.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import SwiftUI

protocol RoutingService {
    func routeToRoverPhotos(manifest: Manifest) -> RoverPhotosView
}

final class AppRouter: ObservableObject {
    @Published var state: ViewDestination = .roverSelectionView
}

enum ViewDestination {
    case roverSelectionView
    case roverPhotosView(manifest: Manifest)
    case photoView
}

extension AppRouter: RoutingService {
    func routeToRoverPhotos(manifest: Manifest) -> RoverPhotosView {
        let viewModel = RoverPhotoViewModel(manifests: manifest)
        return RoverPhotosView(viewModel: viewModel)
    }
}

//protocol RouteToLaunchesContract {
//    func routeToLaunches() -> LaunchesView
//}
//
//extension AppRouter: RouteToLaunchesContract {
//    func routeToLaunches() -> LaunchesView {
//        LaunchesView()
//    }
//}
//
//protocol RouteToRocketsContract {
//    func routeToRockets() -> Text
//}
//
//extension MainRouter: RouteToRocketsContract {
//    func routeToRockets() -> Text {
//        Text("woot rockets")
//    }
//}
//
//protocol RouteToDetailLaunchContract {
//    func routeToDetailLaunch(for launch: Launch) -> DetailLaunchView
//}
//
//extension MainRouter: RouteToDetailLaunchContract {
//    func routeToDetailLaunch(for launch: Launch) -> DetailLaunchView  {
//        let detail = DetailLaunchView()
//        detail.viewModel.setUpVM(for: launch)
//        return detail
//    }
//}
