//
//  ScrollCellViewModel.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import CoreData

class ScrollCellViewModel {
    
    public func favoriteNewSerie(context: NSManagedObjectContext, serie: SerieData) {
        let newSerie = Serie(context: context)
//        newSerie.gender = serie.gender
        newSerie.id = Int32(serie.id)
        newSerie.name = serie.name
        newSerie.overview = serie.overview
        newSerie.posterPath = serie.posterPath
        newSerie.voteAverage = serie.voteAverage
        newSerie.voteCount = Int32(serie.voteCount)
        
        do{
            try context.save()
        } catch {
            print(error)
        }
    }
    
}
