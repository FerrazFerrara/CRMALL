//
//  SerieServiceAPI.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import Foundation
import RxSwift

protocol SerieServiceAPIProtocol{
    
    func getDataArray() -> BehaviorSubject<[SerieData]>
    func fetchListItems(currentListSize: Int)
    
}

class SerieServiceAPI: SerieServiceAPIProtocol{
  
    // this is an observable which holds our data
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
