//
//  SerieServiceAPI.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import Foundation
import RxSwift

/**
 Protocol to comunicate with api
 */
protocol SerieServiceAPIProtocol{
    
    /**
     Get a behavior subject of series
     */
    func getDataArray() -> BehaviorSubject<[SerieData]>
    
    /**
     Fetch data from api and populate series array
     
     - Parameters:
        - currentListSize: how much itens had at list
     */
    func fetchListItems(currentListSize: Int)
    
}

/**
 Class responsable to comunicate between aplication and api
 */
class SerieServiceAPI: SerieServiceAPIProtocol{
  
    /// Observable array to hold series data
    private let seriesObservable = BehaviorSubject<[SerieData]>(value: [])
    
    func getDataArray() -> BehaviorSubject<[SerieData]>{
        return seriesObservable
    }

        
    func fetchListItems(currentListSize: Int){
        var seriesList: [SerieData] = []
        
        let page = currentListSize/20 + 1
        
        SerieStore.shared.fetchSeries(from: .popular, page: page, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case .success(let response):
                seriesList = response.results
                self.seriesObservable.onNext(seriesList)
            case .failure(let error):
                print(error)
            }
        })
    }
  
}
