//
//  Serie.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import Foundation

/**
 Serie Model for API
 */
public struct SerieData: Decodable, Identifiable {
    
    /// id of serie
    public let id: Int
    /// name of serie
    public let name: String
    /// poster path to serie poster image
    public let posterPath: String?
    /// overview of serie
    public let overview: String
    /// vote average of serie
    public let voteAverage: Double
    /// how many people vote for this serie
    public let voteCount: Int
    /// genres of serie
    public let genres: GenreResponse?
    
    /// url of poster
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    /// first genre of serie in string formart
    var genreString: String {
        print(self.genres)
//        return self.genres.results?.first?.name ?? "n/a"
        return "n/a"
    }
}
