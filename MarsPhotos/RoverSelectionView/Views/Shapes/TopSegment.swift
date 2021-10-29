//
//  TopSegment.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 23.10.2021.
//

import SwiftUI

struct TopSegment: Shape {
    
    var selectedRover: RoverName
    
    func path(in rect: CGRect) -> Path {
        
        let grid = layoutConfig.layout(in: rect)
        var path = Path()
        
        if selectedRover == .opportunity {
            path.move(to: grid[0, 0])
            path.addLine(to: grid[100, 0])
            path.addLine(to: grid[100, 31])
            
            path.addLine(to: grid[57, 74])
            path.curve(grid[50, 74], cp1: grid[55, 76], cp2: grid[52, 76])
            
            path.addLine(to: grid[0, 24])
            path.addLine(to: grid[0, 0])
            
        } else {
            path.move(to: grid[4, 4])
            path.addLine(to: grid[90, 4])
            path.curve(grid[96, 9], cp1: grid[94, 4], cp2: grid[96, 6])
            
            path.addLine(to: grid[96, 30])
            path.curve(grid[93, 38], cp1: grid[96, 31], cp2: grid[96, 35])
            
            path.addLine(to: grid[57, 74])
            path.curve(grid[50, 74], cp1: grid[55, 76], cp2: grid[52, 76])
            
            path.addLine(to: grid[6, 30])
            path.curve(grid[4, 25], cp1: grid[4, 28], cp2: grid[4, 24])
            
            path.addLine(to: grid[4, 10])
            path.curve(grid[10, 4], cp1: grid[4, 6], cp2: grid[6, 4])
        }
        
        
                
        return path
    }
}
