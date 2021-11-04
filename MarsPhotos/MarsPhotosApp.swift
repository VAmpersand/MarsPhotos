//
//  MarsPhotosApp.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI

@main
struct MarsPhotosApp: App {
    @StateObject var appRouter = AppRouter()

    @ViewBuilder
    var rootView: some View {
        switch appRouter.state {
        case .roverSelectionView:
            RoverSelectionView()
        case .roverPhotosView(let manifest):
            let viewModel = RoverPhotoViewModel(manifests: manifest)
            RoverPhotosView(viewModel: viewModel)
        case .photoView:
            Text("Photo view")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RoverSelectionView().environmentObject(appRouter)
        }
    }
}
