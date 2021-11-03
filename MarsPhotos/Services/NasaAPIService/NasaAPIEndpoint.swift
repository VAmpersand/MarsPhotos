//
//  NasaAPIEndpoint.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 29.10.2021.
//

import Foundation
import Combine

protocol RequestBuilder {
    var urlRequest: URLRequest { get }
}

enum NasaAPIEndpoint {
    case manifests(rover: Rover)
    case photoForSol(Int, rover: Rover)
    case photoForDate(Date,  rover: Rover)
}

extension NasaAPIEndpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .manifests(let rover):
            guard let url = URL(string: "\(Constants.api)/manifest/\(rover.rawValue)?api_key=\(Constants.apiKey)")
            else { preconditionFailure("Invalid URL format") }
            
            return URLRequest(url: url)
            
        case .photoForSol(let sol, let rover):
            guard let url = URL(string: "\(Constants.api)/rovers/\(rover.rawValue)/photos?sol=\(sol)&api_key=\(Constants.apiKey)")
                else { preconditionFailure("Invalid URL format") }
            
            return URLRequest(url: url)
            
        case .photoForDate(let date, let rover):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateStr = dateFormatter.string(from: date)
        
            guard let url = URL(string: "\(Constants.api)/rovers/\(rover.rawValue)/photos?earth_date=\(dateStr)&api_key=\(Constants.apiKey)")
                else { preconditionFailure("Invalid URL format") }
            
            return URLRequest(url: url)
        }
    }
}
