//
//  FavoritesSeriesViewModel.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import CoreData

class FavoritesSeriesViewModel {
    
    public func fetchData(viewContext: NSManagedObjectContext) -> [SerieData]{
        var seriesCoreData = [Serie]()
        let fetchRequest = NSFetchRequest<Serie>(entityName: "Serie")
        if let fetchedSeries = try? viewContext.fetch(fetchRequest) {
            seriesCoreData = fetchedSeries
        }
        return translateCoreDataSeries(seriesCoreData: seriesCoreData)
    }
    
    private func translateCoreDataSeries(seriesCoreData: [Serie]) -> [SerieData]{
        var seriesData: [SerieData] = []
        
        for serie in seriesCoreData {
            seriesData.append(SerieData(id: Int(serie.id), name: serie.name ?? "Sharknado", posterPath: serie.posterPath, overview: serie.overview ?? "Sem dados", voteAverage: serie.voteAverage, voteCount: Int(serie.voteCount), genres: [SerieGenre(id: 0, name: serie.gender ?? "n/a")]))
        }
        
        return seriesData
    }
    
}
