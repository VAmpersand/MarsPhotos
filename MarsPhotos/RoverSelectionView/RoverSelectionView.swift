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
                
                Spacer()
                        .frame(height: 25)
            
                Text("ROVER")
                    .hPadding(UIScreen.screenWidth * 0.04)
                    .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                    .frame(UIScreen.screenWidth, .infinity, .leading)
                    .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                
                Text("Curiosity")
                    .hPadding(UIScreen.screenWidth * 0.04)
                    .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
                    .frame(UIScreen.screenWidth, .infinity, .leading)
                    .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
                
                Spacer()
            }
            .ignoresSafeArea()
    }
}

struct RoverSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoverSelectionView()
    }
}
