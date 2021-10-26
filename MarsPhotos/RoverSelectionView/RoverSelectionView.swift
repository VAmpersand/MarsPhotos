//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RoverSelectionView: View {
    var body: some View {
        
            VStack {
                ZStack {
                    Image("opportunity")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(TopSegment())
                    
                    Image("spirit")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(LeftSegment())
                    
                    Image("curiosity")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(RightSegment())
                    
                }
                .ignoresSafeArea()
                Spacer()
            }
    }
}

struct RoverSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoverSelectionView()
            .previewDevice(.iPhone_12_Pro_Max)
    }
}
