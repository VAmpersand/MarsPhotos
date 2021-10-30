//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RoverSelectionView: View {
    
    @ObservedObject var viewModel = RoverSelectionViewModel()
    
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
                        .contentShape(TopSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .opportunity
                            withAnimation {
                                selectedItem = RoverName.opportunity.rawValue
                            }
                        }

                    Image("spirit")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(LeftSegment(selectedRover: selectedRover))
                        .contentShape(LeftSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .spirit
                            withAnimation {
                                selectedItem = RoverName.spirit.rawValue
                            }
                        }
                    
                    Image("curiosity")
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .clipShape(RightSegment(selectedRover: selectedRover))
                        .contentShape(RightSegment(selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = .curiosity
                            withAnimation {
                                selectedItem = RoverName.curiosity.rawValue
                            }
                        }
                }
                
                Text("FETCH PHOTO FROM ROVER")
                    .padding(.top)
                    .padding(.leading)
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
        
                Spacer()
                
                Button {
                    self.viewModel.currentRover = self.selectedRover
                    
                } label: {
                    Text("Fetch")
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 15))
                        .frame(UIScreen.screenWidth - 100, .infinity)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .background(Color.blue)
                .frame(UIScreen.screenWidth - 100, 50)
                .clipCapsule()
                .padding()
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

