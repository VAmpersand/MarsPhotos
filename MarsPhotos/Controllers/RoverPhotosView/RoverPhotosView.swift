//
//  RoverPhotosView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import SwiftUI
import PureSwiftUI

// MARK: - RoverPhotosView
struct RoverPhotosView: View {
    
    @ObservedObject var viewModel: RoverPhotoViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                
                Image(Images.getBg(for: .opportunity))
                    .resizable()
                    .resizedToFill()
                    .frame(UIScreen.screenWidth, .infinity, .center)
                
                VStack {
                    Text(self.viewModel.manifest.name.uppercased())
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 32))
                        .padding(.horizontal, Constants.offset)
                        .padding(.top, 80)
                        .frame(UIScreen.screenWidth, .infinity, .leading)
                        .foregroundColor(.white)
                    
                    Text(Strings.roverTitle)
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 18))
                        .padding(.horizontal, Constants.offset)
                        .frame(UIScreen.screenWidth, .infinity, .leading)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .shadow(color: .black, radius: 5, x: 3, y: 3)
            }
            
            Spacer(minLength: 0)
        }
        .ignoresSafeArea()
    }
}

//// MARK: - RoverPhotosView_Previewer
//struct RoverPhotosView_Previewer: PreviewProvider {
//    static var previews: some View {
//        RoverPhotosView()
//    }
//}
