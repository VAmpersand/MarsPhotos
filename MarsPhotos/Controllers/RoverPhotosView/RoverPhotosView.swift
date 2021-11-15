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
                    
                    Image(Images.getBg(for: viewModel.rover))
                        .resizable()
                        .resizedToFill()
                        .frame(frame.width, frame.height)
                    
                    HStack(alignment: .top) {
                        RoverTitleView(rover: viewModel.rover, frame: frame)
                        
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
                            .height(80)
                        
                        GeometryReader { proxy in
                            let height = proxy.frame(in: .global).height
                            let minHeight: CGFloat = 100
                            let midHeight = height - 240
                            let maxHeight = height - 120
                            
                            ManifestInfoView(manifest: viewModel.manifest)
                                .yOffset(height - 175)
                                .yOffset(-offset > 0
                                          ? (-offset <= (midHeight) ? offset : -(midHeight))
                                          : 0)
                            
                            PhotosView(viewModel: self.viewModel,
                                       height: minHeight - (-offset > 0
                                                             ? (-offset < maxHeight ? offset : -maxHeight)
                                                             : 0))
                                .yOffset(height - minHeight)
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
                                                if -offset > minHeight && -offset < midHeight {
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
            InfoView(value: 2452, title: "Day")
            Spacer()
            InfoView(value: 1234, title: "Sol")
            Spacer()
            InfoView(value: 14233, title: "Photos")
            Spacer()
        }
    }
    
    // MARK: - InfoView
    struct InfoView: View {
        var value: Int
        var title: String
        
        var body: some View {
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
}

// MARK: - PhotosView
struct PhotosView: View {
    @ObservedObject var viewModel: RoverPhotoViewModel
    var height: CGFloat
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.black.opacity(0.1))
                .frame(120, 6)
                .padding(.vertical, 11)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(alignment: .top) {
                        let colomnWidth = (UIScreen.screenWidth - 60) / 2
                        
                        VStack() {
                            ForEach((0..<viewModel.leftColumnPhotos.count), id: \.self) { index in
                                PhotoView(photo: viewModel.leftColumnPhotos[index])
                            }
                        }
                        .frame(width: colomnWidth, alignment: .top)
                        
                        Spacer()
                            .width(20)
                        
                        VStack {
                            ForEach((0..<viewModel.rightColumnPhotos.count), id: \.self) { index in
                                PhotoView(photo: viewModel.rightColumnPhotos[index])
                            }
                        }
                        .frame(width: colomnWidth, alignment: .top)
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear.preference(key: ViewFrameKey.self,
                                                   value: proxy.frame(in: .named("scroll")))
                        }
                    )
                    .onPreferenceChange(ViewFrameKey.self) { frame in
                        if !viewModel.inLoading,
                            frame.height != 0,
                            frame.height + frame.origin.y < height {
                            viewModel.loadMorePhoto = ()
                        }
                    }
                    
                    Spacer()
                        .height(20)
                
                    LoaderView()
                }
            }
            .frame(UIScreen.screenWidth - 20, height - 28)
            .padding(.horizontal)
            .clipped()
            .coordinateSpace(name: "scroll")
            
            Spacer()
        }
        .frame(UIScreen.screenWidth, UIScreen.screenHeight - 60)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .contentShape(20, corners: [.topLeft, .topRight])
    }
    
    // MARK: - PhotoView
    struct PhotoView: View {
        var photo: Photo
        
        var body: some View {
            VStack {
                KFImage(URL(string: photo.imgSrc))
//                    .placeholder {
//                        Rectangle()
//                            .fill(.gray)
//                            .frame(width: .infinity, height: .infinity)
//                    }
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 1)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(4)
                
                Spacer()
                    .height(20)
            }
        }
    }
    
    // MARK: - ViewFrameKey
    struct ViewFrameKey: PreferenceKey {
        typealias Value = CGRect
        
        static var defaultValue = CGRect(x: 0, y: 0, width: 0, height: 0)
        static func reduce(value: inout Value, nextValue: () -> Value)  {
            let rectOffsetX = value.origin.x + nextValue().origin.x
            let rectOffsetY = value.origin.y + nextValue().origin.y
            let rectWidth = value.width + nextValue().width
            let rectHeight = value.height + nextValue().height
            
            value = CGRect(rectOffsetX, rectOffsetY, rectWidth, rectHeight)
        }
    }
}

// MARK: - LoaderView
struct LoaderView: View {
   @State var angle = 0.0
    
    var body: some View {
        HStack {
            Image(systemName: "hourglass")
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(20)
                .foregroundColor(Color(hex: Colors.titleGray.rawValue))
//                .rotate(.degrees(angle))
//                .animation(
//                    Animation
//                        .linear(duration: 0.5)
//                        .delay(0)
//                        .repeatForever()
//                )
//                .onAppear {
//                    angle += 360
//                }
            
            Spacer()
                .width(10)
            
            Text(Strings.waitLabel)
                .font(Font.custom(Fonts.latoHeavy.rawValue, fixedSize: 17))
                .foregroundColor(Color(hex: Colors.titleGray.rawValue))
                .padding()
        }
        .padding()
    }
}
