//
//  LeftSegemnt.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 26.10.2021.
//

import SwiftUI

struct LeftSegment: Shape {
    
    var selectedRover: RoverName
    
    func path(in rect: CGRect) -> Path {
        
        let grid = layoutConfig.layout(in: rect)
        var path = Path()
        
        if selectedRover == .spirit {
            path.move(to: grid[0, 32])
            path.addLine(to: grid[91, 122])
            path.curve(grid[89, 126], cp1: grid[92, 123], cp2: grid[92, 126])
            
            path.addLine(to: grid[0, 126])
            path.addLine(to: grid[0, 27])
            
        } else {
            path.move(to: grid[8, 39])
            path.addLine(to: grid[91, 122])
            path.curve(grid[89, 126], cp1: grid[92, 123], cp2: grid[92, 126])
            
            path.addLine(to: grid[9, 126])
            path.curve(grid[4, 121], cp1: grid[5, 126], cp2: grid[4, 122])
            
            path.addLine(to: grid[4, 41])
            path.curve(grid[8, 39], cp1: grid[4, 38], cp2: grid[7, 38])
        }
        
        return path
    }
}
