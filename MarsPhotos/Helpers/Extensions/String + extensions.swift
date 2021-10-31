//
//  String + extensions.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 31.10.2021.
//

import Foundation

extension String {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() } 
}
