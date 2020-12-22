//
//  SerieService.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation

/**
 Protocol of getting data from api
 */
protocol SerieService {
    
    /**
     Fetch series from api based on some parameters
     
     - Parameters:
        - endpoint: options of endpoints to fetch from api
        - page: which page get data from api
        - completion: Result of fetch, return a response and an error
     */
    func fetchSeries(from endpoint: SerieListEndpoint, page: Int, completion: @escaping (Result<SerieResponse, SerieError>) -> ())
    
    func fetchGenre(completion: @escaping (Result<[SerieGenre], SerieError>) -> Void)
    
}

/**
 Options of endpoint to get data
 */
enum SerieListEndpoint: String, CaseIterable {
    /// series that are playing
    case nowPlaying = "now_playing"
    
    /// dont release series
    case upcoming
    
    /// most rated series
    case topRated = "top_rated"
    
    /// most popular series
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

/**
 Possible Erros to receive
 */
enum SerieError: Error, CustomNSError {
    /// Failed to fetch data
    case apiError
    
    /// Invalid EndPoint
    case invalidEndPoint
    
    /// Invalid Response
    case invalidResponse
    
    /// No data received
    case noData
    
    /// Failed to decode data
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
