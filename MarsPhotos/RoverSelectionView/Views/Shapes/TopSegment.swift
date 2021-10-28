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
        
        let grid = layoutConfig.layout(in: rect)
        
        path.move(to: grid[0, 0])
        path.addLine(to: grid[100, 0])
        path.addLine(to: grid[100, 31])
        
        path.addLine(to: grid[57, 74])
        path.curve(grid[50, 74], cp1: grid[55, 76], cp2: grid[52, 76])
                
        path.addLine(to: grid[0, 24])
        path.addLine(to: grid[0, 0])
                
        return path
    }
}
