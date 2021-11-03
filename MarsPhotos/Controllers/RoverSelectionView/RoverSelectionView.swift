//
//  RoverSelectionView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 22.10.2021.
//

import SwiftUI
import PureSwiftUI

// MARK: - RoverSelectionView
struct RoverSelectionView: View {
    
    @ObservedObject var viewModel = RoverSelectionViewModel()
    
    @State private var selectedRover: Rover = .opportunity
    @State private var showSafari = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ZStack {
                        ForEach(Rover.allCases, id: \.self) { rover in
                            Image(rover.rawValue)
                                .resizable()
                                .scaledToFill()
                                .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                                .modifier(ClipAnimatedShape(rover: rover, selectedRover: selectedRover))
                                .onTapGesture {
                                    withAnimation { selectedRover = rover }
                                }
                        }
                    }.padding(.top, 10)
                    
                    Text(Strings.roverTitle.uppercased())
                        .padding(.horizontal, Constants.offset)
                        .padding(.top, 10)
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                        .frame(UIScreen.screenWidth, .infinity, .leading)
                        .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                    
                    TabView(selection: $selectedRover.animation(.linear(duration: 0.15))) {
                        ForEach(Rover.allCases, id: \.self) { rover in
                            getRoverInfoView(for: rover)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(UIScreen.screenWidth, 250, .leading)
                    
                    Spacer()
                        .frame(height: 100)
                }
            }
            
            VStack {
                Spacer()
                
                Button {
                    self.viewModel.selectedRover = self.selectedRover
                    
                } label: {
                    Text("Fetch")
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 15))
                        .frame(UIScreen.screenWidth - 100, .infinity)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .background(Color.blue)
                .frame(.infinity, 50, .bottom)
                .clipCapsule()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: -3)
                .padding(.horizontal, 50)
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func getRoverInfoView(for rover: Rover) -> some View {
        VStack {
            Text(rover.rawValue.firstUppercased)
                .font(Font.custom(Fonts.abrilFatface.rawValue, fixedSize: 32))
                .padding(.horizontal, Constants.offset)
                .padding(.bottom, 10)
                .frame(UIScreen.screenWidth, .infinity, .leading)
                .foregroundColor(Color.init(hex: Colors.titleDarkGray.rawValue))
            
            Text(Strings.missionTitle.uppercased())
                .padding(.horizontal, Constants.offset)
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                .frame(UIScreen.screenWidth, .infinity, .leading)
                .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
              
            Text(Strings.getMissionInfo(for: rover))
                .padding(.horizontal, Constants.offset)
                .padding(.top, 3)
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                .frame(UIScreen.screenWidth, .infinity, .leading)
                .foregroundColor(Color.init(hex: Colors.titleGray.rawValue).opacity(0.9))
                .lineLimit(10)
            
            HStack {
                Text(Strings.moreLabel.uppercased())
                    .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                    .frame(.infinity, .infinity, .trailing)
                    .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                
                Image(systemName: "ellipsis.circle")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .frame(20)
                    .foregroundColor(Color(hex: Colors.titleGray.rawValue))
                
            }
            .padding(.horizontal, Constants.offset)
            .frame(UIScreen.screenWidth, 32, .trailing)
        }
        .onTapGesture {
            self.showSafari = true
        }
        .sheet(isPresented: $showSafari) {
            SafariView(url: Constants.getOficialSiteURL(for: rover))
        }
    }
}

// MARK: - ClipAnimatedShape
struct ClipAnimatedShape: ViewModifier {
    
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
                .animation(.linear(duration: 0.15))
                .offset(-offset * 0.2, -offset * 1.3)
            
        case .spirit:
            content
                .clipShape(SpiritSegment())
                .contentShape(SpiritSegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .animation(.linear(duration: 0.15))
                .offset(-offset * 4, -offset * 5)
            
        case .curiosity:
            content
                .clipShape(CuriositySegment())
                .contentShape(CuriositySegment())
                .scaleEffect(rover == selectedRover ? 1.2 : 1)
                .animation(.linear(duration: 0.15))
                .offset(offset * 0.07, -offset * 1.2)
        }
    }
}

//// MARK: - RoverSelectionView_Previewer
//struct RoverSelectionView_Previewer: PreviewProvider {
//    static var previews: some View {
//        RoverSelectionView()
//    }
//}
