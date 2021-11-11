//
//  RoverPhotosView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import SwiftUI
import PureSwiftUI
import Kingfisher

// MARK: - RoverPhotosView
struct RoverPhotosView: View {
    
    @ObservedObject var viewModel: RoverPhotoViewModel
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    
                    Image(Images.getBg(for: viewModel.selectedRover))
                        .resizable()
                        .resizedToFill()
                        .frame(frame.width, frame.height)
                    
                    HStack(alignment: .top) {
                        RoverTitleView(rover: viewModel.selectedRover, frame: frame)
                        
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(systemName: "xmark")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFill()
                                .frame(20)
                                .padding(.top, Constants.offset / 2)
                                .foregroundColor(.white)
                        }
                    }
                    .yOffset(getTitelOffset())
                    .shadow(color: .black, radius: 5, x: 3, y: 3)
                    
                    VStack {
                        Spacer()
                            .frame(height: 80)
                        
                        GeometryReader { proxy in
                            let height = proxy.frame(in: .global).height
                            let maxHeight = height - 120
                            let midHeight = maxHeight - 220
                            
                            ManifestInfoView(manifest: viewModel.manifest)
                                .yOffset(height - 190)
                                .yOffset(-offset > 0
                                          ? (-offset <= (midHeight) ? offset : -(midHeight))
                                          : 0)
                            
                            PhotosView(leftColumn: viewModel.leftColumnPhotos, rightColumn: viewModel.rightColumnPhotos)
                                .yOffset(height - 100)
                                .yOffset(-offset > 0
                                          ? (-offset < maxHeight ? offset : -maxHeight)
                                          : 0)
                                .scale(getChangingProgress())
                                .opacity(Double(getChangingProgress()))
                                .gesture(
                                    DragGesture()
                                        .updating($gestureOffset, body: { value, output, _ in
                                            output = value.translation.height
                                            
                                            onChanged()
                                        })
                                        .onEnded { value in
                                            withAnimation {
                                                if -offset > 100 && -offset < midHeight {
                                                    offset = -midHeight
                                                    
                                                } else if -offset > midHeight {
                                                    offset = -maxHeight
                                                    
                                                } else {
                                                    offset = 0
                                                }
                                            }
                                            
                                            lastOffset = offset
                                        }
                                )
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
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
    
    func getTitelOffset() -> CGFloat {
        let offset = 80 + (35 * (offset / UIScreen.screenHeight))
        return offset > 80 ? 80 : (offset < 55 ? 55 : offset)
    }
}

//MARK: - RoverTitleView
struct RoverTitleView: View {
    
    var rover: Rover
    var frame: CGRect
    
    var body: some View {
        VStack(spacing: 10) {
            Text((rover.rawValue).uppercased())
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 32))
                .padding(.horizontal, Constants.offset)
                .frame(frame.width - 50, .infinity, .leading)
                .foregroundColor(.white)
            
            Text(Strings.roverTitle)
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 18))
                .padding(.horizontal, Constants.offset)
                .frame(frame.width - 50, .infinity, .leading)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

// MARK: - ManifestInfoView
struct ManifestInfoView: View {
    
    var manifest: Manifest?
    
    var body: some View {
        HStack {
            Spacer()
            infoView(for: 2452, title: "Day")
            Spacer()
            infoView(for: 1234, title: "Sol")
            Spacer()
            infoView(for: 14233, title: "Photos")
            Spacer()
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
}


// MARK: - PhotosView
struct PhotosView: View {
    
    var leftColumn: [Photo]
    var rightColumn: [Photo]
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.black.opacity(0.1))
                .frame(120, 6)
                .padding(.vertical, 11)
            
            ScrollView(showsIndicators: false) {
                let colomnWidth = (UIScreen.screenWidth - 60) / 2
                
                HStack(alignment: .top) {
                    VStack() {
                        ForEach((0..<leftColumn.count), id: \.self) { index in
                            photoView(photo: leftColumn[index])
                        }
                    }
                    .frame(width: colomnWidth, alignment: .top)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    VStack {
                        ForEach((0..<rightColumn.count), id: \.self) { index in
                            photoView(photo: rightColumn[index])
                        }
                    }
                    .frame(width: colomnWidth, alignment: .top)
                }
                
            }
            .frame(UIScreen.screenWidth - 20, .infinity)
            .padding(.horizontal)
            .clipped()
        }
        .frame(UIScreen.screenWidth, UIScreen.screenHeight - 60)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .contentShape(20, corners: [.topLeft, .topRight])
    }
    
    @ViewBuilder
    func photoView(photo: Photo) -> some View {
        VStack {
            KFImage(URL(string: photo.imgSrc))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 1)
                .resizable()
                .scaledToFit()
                .cornerRadius(4)
            
            Spacer()
                .frame(height: 20)
        }
    }
}

//// MARK: - RoverPhotosView_Previewer
//struct RoverPhotosView_Previewer: PreviewProvider {
//    static var previews: some View {
//        RoverPhotosView()
//    }
//}
