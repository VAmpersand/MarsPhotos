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
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ZStack {
                            ForEach(Rover.allCases, id: \.self) { rover in
                                Image(Images.getShapesBg(for: rover))
                                    .resizable()
                                    .scaledToFill()

                                    .modifier(ClipAnimatedShape(rover: rover, selectedRover: viewModel.selectedRover))
                                    .onTapGesture {
                                        withAnimation { viewModel.selectedRover = rover }
                                    }
                            }
                        }
                        .frame(UIScreen.screenWidth, UIScreen.screenWidth * 1.255, .trailing)
                        .padding(.top, 10)
                        
                        Text(Strings.fetchPhotoTitle.uppercased())
                            .padding(.horizontal, Constants.offset)
                            .padding(.top, 10)
                            .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 12))
                            .frame(UIScreen.screenWidth, .infinity, .leading)
                            .foregroundColor(Color.init(hex: Colors.titleGray.rawValue))
                        
                        TabView(selection: $viewModel.selectedRover.animation(.linear(duration: 0.15))) {
                            ForEach(Rover.allCases, id: \.self) { rover in
                                RoverInfoView(rover: rover)
                                    .onTapGesture {
                                        self.viewModel.routeToSafariView = true
                                    }
                                    .sheet(isPresented: $viewModel.routeToSafariView) {
                                        SafariView(url: Constants.getOficialSiteURL(for: rover))
                                    }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(UIScreen.screenWidth, 250, .leading)
                        
                        Spacer()
                            .height(100)
                    }
                }
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button {
                            viewModel.routeToPhotosView = true
                        } label: {
                            NavigationLink(destination: PhotosView(rover: viewModel.selectedRover),
                                           isActive: $viewModel.routeToPhotosView) {}
                                           .width(0)
                            
                            Text(Strings.fetchLabel)
                                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 15))
                                .frame(UIScreen.screenWidth - 200, .infinity)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                        .background(Color.blue)
                        .frame(.infinity, 50)
                        .clipCapsule()
                        
//                        Spacer()
//                            .width(20)
        
                        Button {
                            viewModel.routeToPhotosByDateView = true
                        } label: {
                            NavigationLink(destination: Text("Photo by date"),
                                           isActive: $viewModel.routeToPhotosByDateView) {}
                                           .width(0)
                            
                            Image(systemName: "calendar")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(20)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .padding(.horizontal, 25)
                        }
                        .background(Color.blue)
                        .frame(.infinity, 50)
                        .clipCapsule()
                    }
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: -3)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)

                }
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }

    // MARK: - PhotosView
    struct PhotosView: View {
        var rover: Rover
        
        var body: some View {
            let viewModel = RoverPhotoViewModel(rover: rover)
            RoverPhotosView(viewModel: viewModel)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - RoverInfoView
struct RoverInfoView: View {
    var rover: Rover
    
    var body: some View {
        VStack {
            Text(rover.rawValue.uppercased())
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 32))
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
