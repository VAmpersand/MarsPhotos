//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI

struct RoverSelectionView: View {
    var body: some View {
        VStack {
            Image("spirit")
                .resizable()
                .scaledToFit()
                .frame(alignment: .top)
                .clipShape(TopSegment())
                .ignoresSafeArea()
            Spacer()
        }
    }
}

struct RoverSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoverSelectionView()
    }
}
