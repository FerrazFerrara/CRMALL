//
//  SerieResponse.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 22/12/20.
//

import Foundation

/**
 Serie Response
 */
public struct SerieResponse: Decodable {
    /// array of series as a result
    public let results: [SerieData]
}
