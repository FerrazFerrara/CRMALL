//
//  SerieGenre.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 22/12/20.
//

import Foundation

/**
 Genre Model
 */
public struct SerieGenre: Decodable {
    let id: Int
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
