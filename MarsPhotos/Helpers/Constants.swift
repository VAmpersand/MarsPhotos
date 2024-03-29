//
//  Constants.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 26.10.2021.
//

import SwiftUI
import PureSwiftUI

struct Constants {
    // MARK: - Layout
    static let layoutConfig = LayoutGuideConfig.grid(columns: 100, rows: 126)
    static let offset = UIScreen.screenWidth * 0.04
    
    // MARK: - API
    static let apiKey = "eb0Q4TEg6PKMZTlKogsUBgxQWGHH1SrWEgqfQxP4"
    static let api = "https://api.nasa.gov/mars-photos/api/v1"
 
    // MARK: - URL
    static func getOficialSiteURL(for rover: Rover) -> URL {
        var urlStr: String {
            switch rover {
            case .opportunity: return "https://www.jpl.nasa.gov/missions/mars-exploration-rover-opportunity-mer"
            case .spirit: return "https://www.jpl.nasa.gov/missions/mars-exploration-rover-spirit-mer-spirit"
            case .curiosity: return "https://mars.nasa.gov/msl/mission/overview/"
            }
        }
        
        guard let url = URL(string: urlStr) else  {
            fatalError("Error: Oficial site URL faled")
        }
        
        return url
    }
    
   
}
