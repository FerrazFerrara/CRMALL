//
//  GenreResponse.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 22/12/20.
//

import Foundation

/**
 Genre Response
 */
public struct GenreResponse: Decodable {
    /// array of series as a result
    public var genres: [SerieGenre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
