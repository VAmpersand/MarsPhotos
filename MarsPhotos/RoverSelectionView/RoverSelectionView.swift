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
                ForEach(RoverName.allCases, id: \.self) { name in
                    Image(name.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .modifier(ClipRoverShape(roverName: name, selectedRover: selectedRover))
                        .onTapGesture {
                            selectedRover = name
                            withAnimation {
                                selectedItem = name.rawValue
                            }
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
        Text(name.rawValue.firstUppercased)
            .offset(UIScreen.screenWidth * 0.04, 0)
            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
            .frame(UIScreen.screenWidth, .infinity, .leading)
            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
    }
}


struct ClipRoverShape: ViewModifier {
    
    var roverName: RoverName
    var selectedRover: RoverName
    
    func body(content: Content) -> some View {
        switch roverName {
        case .opportunity:
            content
                .clipShape(OpportunitySegment(selectedRover: selectedRover))
                .contentShape(OpportunitySegment(selectedRover: selectedRover))
        case .spirit:
            content
                .clipShape(SpiritSegment(selectedRover: selectedRover))
                .contentShape(SpiritSegment(selectedRover: selectedRover))
        case .curiosity:
            content
                .clipShape(CuriositySegment(selectedRover: selectedRover))
                .contentShape(CuriositySegment(selectedRover: selectedRover))
        }
    }
}
