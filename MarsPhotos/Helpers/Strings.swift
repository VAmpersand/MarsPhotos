//
//  Strings.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation

struct Strings {
    static let missionTitle = "Mission"
    static let fetchPhotoTitle = "Fetch photo from rover"
    static let roverTitle = "Nasa Mars rover"
    
    static let moreLabel = "More"
    static let fetchLabel = "Fetch all"
    static let waitLabel = "Please wait..."
    
    static func getMissionInfo(for rover: Rover) -> String {
        switch rover {
        case .opportunity: return """
        Opportunity was the second of the two rovers launched in 2003 to land on Mars and begin traversing the Red Planet in search of signs of ancient water. The rover explored the Martian terrain for almost 15 years, far outlasting her planned 90-day mission.

        After landing on Mars in 2004, Opportunity made a number of discoveries about the Red Planet including dramatic evidence that long ago at least one area of Mars stayed wet for an extended period and that conditions could have been suitable for sustaining microbial life.
        """
            
        case .spirit: return """
        One of two rovers launched in 2003 to explore Mars and search for signs of past life, Spirit far outlasted her planned 90-day mission, lasting over six years. Among her myriad discoveries, Spirit found evidence that Mars was once much wetter than it is today and helped scientists better understand the Martian wind.

        In May 2009, the rover became embedded in soft soil at a site called "Troy" with only five working wheels to aid in the rescue effort. After months of testing and carefully planned maneuvers, NASA ended efforts to free the rover and eventually ended the mission on May 25, 2011.
        """
            
        case .curiosity: return """
        Part of NASA's Mars Science Laboratory mission, Curiosity is the largest and most capable rover ever sent to Mars. It launched Nov. 26, 2011 and landed on Mars at 10:32 p.m. PDT on Aug. 5, 2012 (1:32 a.m. EDT on Aug. 6, 2012).

        Curiosity set out to answer the question: Did Mars ever have the right environmental conditions to support small life forms called microbes? Early in its mission, Curiosity's scientific tools found chemical and mineral evidence of past habitable environments on Mars. It continues to explore the rock record from a time when Mars could have been home to microbial life.
        """
        }
    }
}
