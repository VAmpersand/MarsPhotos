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
    
    //    @ObservedObject var viewModel: RoverPhotoViewModel
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
        
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Image(Images.getBg(for: .spirit)) // viewModel.manifest.rover))
                    .resizable()
                    .resizedToFill()
                    .frame(frame.width, frame.height)
                
                VStack(spacing: 10) {
                    Text("self.viewModel.manifest.name".uppercased())
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 32))
                        .padding(.horizontal, Constants.offset)
                        .frame(frame.width, .infinity, .leading)
                        .foregroundColor(.white)
                    
                    Text(Strings.roverTitle)
                        .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 18))
                        .padding(.horizontal, Constants.offset)
                        .frame(frame.width, .infinity, .leading)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .yOffset(80)
                .shadow(color: .black, radius: 5, x: 3, y: 3)
                
                VStack {
                    Spacer()
                        .frame(height: 80)
                    
                    GeometryReader { proxy in
                        let height = proxy.frame(in: .global).height
                        let maxHeight = height - 60
                        
                        HStack {
                            Spacer()
                            infoView(for: 2452, title: "Day")
                            Spacer()
                            infoView(for: 1234, title: "Sol")
                            Spacer()
                            infoView(for: 14233, title: "Photos")
                            Spacer()
                        }
                        .yOffset(height - 150)
                        .yOffset(-offset > 0
                                  ? (-offset <= (maxHeight / 2) ? offset : -(maxHeight / 2))
                                  : 0)
                        
                        PhotosView()
                            .yOffset(height - 60)
                            .yOffset(-offset > 0
                                      ? (-offset <= maxHeight ? offset : -maxHeight)
                                      : 0)
                            .scale(getChangingProgress())
                            .opacity(Double(getChangingProgress()))
                            .gesture(
                                DragGesture().updating($gestureOffset, body: { value, output, _ in
                                    output = value.translation.height
                                    
                                    onChanged()
                                })
                                    .onEnded { value in
                                        withAnimation {
                                            if -offset > 100 && -offset < maxHeight / 2 {
                                                offset = -maxHeight / 2
                                                
                                            } else if -offset > maxHeight / 2 {
                                                offset = -maxHeight
                                                
                                            } else {
                                                offset = 0
                                            }
                                        }
                                        print(offset)
                                        lastOffset = offset
                                    }
                            )
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func infoView(for value: Int, title: String) -> some View {
        VStack {
            Text("\(value)")
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 24))
                .foregroundColor(.white)
            
            Text(title)
                .font(Font.custom(Fonts.pingFang.rawValue, fixedSize: 16))
                .fontWeight(.light)
                .foregroundColor(.white)
        }
        .shadow(color: .black, radius: 5, x: 3, y: 3)
    }
    
    func onChanged() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getChangingProgress() -> CGFloat {
        let progress = 0.95 - (offset / (UIScreen.screenHeight / 2) * 0.1)
        return progress < 0.95 ? 0.95 : (progress > 1 ? 1 : progress)
    }
    
//    func getTitelOffset() -> CGFloat {
//        let porgress = -(offset / UIScreen.screenHeight)
//    }
//}

// MARK: - PhotosView
struct PhotosView: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.black.opacity(0.1))
                .frame(120, 6)
                .padding(.vertical, 11)
            
            VStack {
                Spacer()
            }
            .frame(UIScreen.screenWidth - 36, .infinity)
            .background(Color.gray.opacity(0.4))
            .padding(.horizontal)
        }
        .frame(UIScreen.screenWidth, UIScreen.screenHeight - 60)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

// MARK: - RoverPhotosView_Previewer
struct RoverPhotosView_Previewer: PreviewProvider {
    static var previews: some View {
        RoverPhotosView()
    }
}
