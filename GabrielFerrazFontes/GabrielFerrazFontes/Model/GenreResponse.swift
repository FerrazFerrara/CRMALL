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
    public let results: [SerieGenre]
}
