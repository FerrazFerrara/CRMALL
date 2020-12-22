//
//  SerieService.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation

protocol SerieService {
    
    func fetchSeries(from endpoint: SerieListEndpoint, page: Int, completion: @escaping (Result<SerieResponse, SerieError>) -> ())
    
}

enum SerieListEndpoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

enum SerieError: Error, CustomNSError {
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
            case .apiError: return "Failed to fetch data"
            case .invalidEndPoint: return "Invalid endpoint"
            case .invalidResponse: return "Invalid response"
            case .noData: return "No data"
            case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
