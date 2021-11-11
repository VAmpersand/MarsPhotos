//
//  View + extensions.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 04.11.2021.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func contentShape(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        contentShape(RoundedCorner(radius: radius, corners: corners))
    }
}
