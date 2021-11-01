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
    
    @State private var selectedRover: Rover = .opportunity
    
    var body: some View {
        
        VStack {
            ZStack {
                ForEach(Rover.allCases, id: \.self) { rover in
                    Image(rover.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .modifier(ClipRoverShape(rover: rover, selectedRover: selectedRover))
                        .onTapGesture {
                            withAnimation {
                                selectedRover = rover
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
            
            TabView(selection: $selectedRover) {
                ForEach(Rover.allCases, id: \.self) { rover in
                    getTitleViewFor(rover: rover)
                }
            }
            .disabled(true)
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
    func getTitleViewFor(rover name: Rover) -> some View {
        Text(name.rawValue.firstUppercased)
            .offset(UIScreen.screenWidth * 0.04, 0)
            .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
            .frame(UIScreen.screenWidth, .infinity, .leading)
            .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
    }
}


struct ClipRoverShape: ViewModifier {
    
    var rover: Rover
    var selectedRover: Rover
    
    func body(content: Content) -> some View {
        let offset: CGFloat = rover == selectedRover ? UIScreen.screenWidth * 0.025 : 0
        
        switch rover {
        case .opportunity:
            content
                .clipShape(OpportunitySegment())
                .contentShape(OpportunitySegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .offset(-offset * 0.2, -offset * 1.3)
            
        case .spirit:
            content
                .clipShape(SpiritSegment())
                .contentShape(SpiritSegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .offset(-offset * 4, -offset * 5)
            
        case .curiosity:
            content
                .clipShape(CuriositySegment())
                .contentShape(CuriositySegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .offset(offset * 0.07, -offset * 1.2)
        }
    }
}

//struct RoverSelectionView_Previewer: PreviewProvider {
//    static var previews: some View {
//        RoverSelectionView()
//    }
//}
