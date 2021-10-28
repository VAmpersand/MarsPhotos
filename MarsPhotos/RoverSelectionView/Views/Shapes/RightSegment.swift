//
//  RightSegments.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 24.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RightSegment: Shape {
    
    var selectedRover: RoverName

    func path(in rect: CGRect) -> Path {
        
        let grid = layoutConfig.layout(in: rect)
        var path = Path()
        
        if selectedRover == .curiosity {
            path.move(to: grid[100, 37])
            path.addLine(to: grid[100, 124])
            
            path.addLine(to: grid[60, 84])
            path.curve(grid[60, 77], cp1: grid[58, 82], cp2: grid[58, 79])
            
            path.addLine(to: grid[100, 37])
            
        } else {
            path.move(to: grid[96, 47])
            path.addLine(to: grid[96, 113])
            path.curve(grid[91, 115], cp1: grid[96, 115], cp2: grid[94, 117])
            
            path.addLine(to: grid[60, 84])
            path.curve(grid[60, 77], cp1: grid[58, 82], cp2: grid[58, 79])
            
            path.addLine(to: grid[92, 46])
            path.curve(grid[96, 48], cp1: grid[93, 45], cp2: grid[96, 44])
        }
        
        return path
    }
}
