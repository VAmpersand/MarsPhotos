//
//  RightSegments.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 24.10.2021.
//

import SwiftUI
import PureSwiftUI

struct RightSegment: Shape {

    func path(in rect: CGRect) -> Path {
        
        let grid = layoutConfig.layout(in: rect)
        
        var path = Path()
        
        //  If segemtn was selected
        //            path.move(to: grid[100, 37])
        //            path.addLine(to: grid[100, 124])
        //
        //            path.addLine(to: grid[60, 84])
        //            path.curve(grid[60, 77], cp1: grid[58, 82], cp2: grid[58, 79])
        //
        //            path.addLine(to: grid[100, 37])
        //
        
        path.move(to:  grid[95, 47])
        path.addLine(to: grid[95, 114])
        path.curve(grid[92, 116], cp1: grid[95, 116], cp2: grid[94, 117])
        
        path.addLine(to: grid[60, 84])
        path.curve(grid[60, 77], cp1: grid[58, 82], cp2: grid[58, 79])
        
        path.addLine(to: grid[92, 46])
        path.curve(grid[95, 47], cp1: grid[93, 45], cp2: grid[95, 45])
        
        return path
    }
}
