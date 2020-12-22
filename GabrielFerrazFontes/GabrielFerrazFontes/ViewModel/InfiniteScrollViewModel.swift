//
//  InfiniteScrollViewModel.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import RxSwift

/**
 View Model of infinite Scroll
 */
class InfiniteScrollViewModel {
    
    /// reference to get series list
    let infiniteScrollRepo: SerieServiceAPIProtocol
    /// delegate to send array of series to view
    var viewUpdate: ViewUpdateProtocol? = nil
    /// memory leak controller
    let disposeBag = DisposeBag()
    
    init (infiniteScrollRepo: SerieServiceAPIProtocol = SerieServiceAPI()){
        
        self.infiniteScrollRepo = infiniteScrollRepo
        
        // subscribe and start listening for changes in array
        self.infiniteScrollRepo.getDataArray().subscribe({ [weak self] newList in
            
            // update list in View class whenever list changes
            self?.updateListItems(newList: newList.element)
            
        }).disposed(by: disposeBag)
        
    }
    
    
    func getNewItems(currentListSize: Int){
        
        // fetch new list items
        infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)
        
    }
    
    func updateListItems(newList: [SerieData]?){
        if newList != nil && !newList!.isEmpty{
            // append new lists to the bottom of the list at view
            self.viewUpdate?.appendData(list: newList)
        }
    }
    
}
