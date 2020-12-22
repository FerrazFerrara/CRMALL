//
//  Utils.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation

/**
 Class used as a constants holder
 */
class Utils {
    
    /// Decoder of JSON
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    /// Date formatter used "yyyy-mm-dd"
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
