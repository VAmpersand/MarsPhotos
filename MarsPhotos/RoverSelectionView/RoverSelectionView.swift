//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RoverSelectionView: View {
    
    @State var selectedRover: RoverName = .opportunity
    
    var body: some View {
        
            VStack {
                ZStack {
                    Image("opportunity")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(TopSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .opportunity
                        }
                    
                    Image("spirit")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(LeftSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .spirit
                        }
                    
                    Image("curiosity")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(RightSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .curiosity
                        }
                }
                
                Text("ROVER")
                    .offset(UIScreen.screenWidth * 0.04, 25)
                    .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                    .frame(UIScreen.screenWidth, .infinity, .leading)
                    .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                
                Text("Curiosity")
                    .offset(UIScreen.screenWidth * 0.04, 25)
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
        Group {
            RoverSelectionView()
        }
    }
}
