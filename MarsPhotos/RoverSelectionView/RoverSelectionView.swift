//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RoverSelectionView: View {
    
    @State private var selectedRover: RoverName = .opportunity
    @State private var selectedItem = RoverName.opportunity.rawValue
    
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
                
                Text("FETCH PHOTO FROM ROVER")
                    .offset(UIScreen.screenWidth * 0.04, 25)
                    .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                    .frame(UIScreen.screenWidth, .infinity, .leading)
                    .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                
                TabView(selection: $selectedItem){
                    ForEach(RoverName.allCases, id: \.self) { name in
                        getTitleViewFor(rover: name)
                            .tag(name.rawValue)
                            .onDisappear {
                                selectedRover = RoverName(rawValue: self.selectedItem) ?? .opportunity
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(UIScreen.screenWidth, 40, .leading)
                .offset(0, 20)
                
                
//                
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack(spacing: UIScreen.screenWidth / 2) {
//                        Text("Opportunity")
//                            .offset(UIScreen.screenWidth * 0.04, 0)
//                            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
//                            .frame(UIScreen.screenWidth / 2, .infinity, .topLeading)
//                            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
//                        
//                        Text("Spirit")
//                            .offset(UIScreen.screenWidth * 0.04, 0)
//                            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
//                            .frame(UIScreen.screenWidth / 2, .infinity, .topLeading)
//                            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
//                        
//                        Text("Curiosity")
//                            .offset(UIScreen.screenWidth * 0.04, 0)
//                            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
//                            .frame(UIScreen.screenWidth / 2, .infinity, .topLeading)
//                            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
//                        
//                    }
//                }
//                .offset(0, 20)
//                .background(Color.red)
//                .frame(width: .infinity, height: 20)
               
                
//                Text("Curiosity")
//                    .offset(UIScreen.screenWidth * 0.04, 25)
//                    .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
//                    .frame(UIScreen.screenWidth, .infinity, .leading)
//                    .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
                
                Spacer()
            }
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    func getTitleViewFor(rover name: RoverName) -> some View {
        Text(Strings.getTitleFor(rover: name))
            .offset(UIScreen.screenWidth * 0.04, 0)
            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
            .frame(UIScreen.screenWidth, .infinity, .leading)
            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))

    }
}

struct RoverSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoverSelectionView()
        }
    }
}
