//
//  TopSegment.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import SwiftUI

struct TopSegment: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //Top horisontal line
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        //Left vertical line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + rect.height * 0.42))
        
        //Bottom curve
        let centerX = rect.midX + rect.width * 0.1
        let centerY = rect.maxY - rect.height * 0.05
        path.addLine(to: CGPoint(x: centerX + 12, y: centerY))
        path.addQuadCurve(to: CGPoint(x: centerX - 12, y: centerY),
                          control: CGPoint(x: centerX, y: centerY + 10))
        
        //Right vertical line
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.32))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}
