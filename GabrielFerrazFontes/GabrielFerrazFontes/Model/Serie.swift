//
//  Serie.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import Foundation

public struct SerieResponse: Decodable {
    public let results: [SerieData]
}

public struct SerieData: Decodable, Identifiable {
    
    public let id: Int
    public let name: String
    public let posterPath: String?
    public let overview: String
    public let voteAverage: Double
    public let voteCount: Int
    public let genres: [SerieGenre]?
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    var genreString: String {
        print(self.genres)
        return self.genres?.first?.name ?? "n/a"
    }
}

public struct SerieGenre: Decodable {
    let id: Int
    let name: String
}
