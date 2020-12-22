//
//  InfiniteScrollViewModel.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import RxSwift

class InfiniteScrollViewModel {

  let infiniteScrollRepo: SerieServiceAPIProtocol
  var viewUpdate: ViewUpdateProtocol? = nil
  let disposeBag = DisposeBag()

  init (infiniteScrollRepo: SerieServiceAPIProtocol = SerieServiceAPI()){

    self.infiniteScrollRepo = infiniteScrollRepo

    // subscribe and start listening for changes in our data
    self.infiniteScrollRepo.getDataArray().subscribe({ [weak self] newList in

      // update list in our View class whenever list changes
      self?.updateListItems(newList: newList.element)
                                                      
    }).disposed(by: disposeBag)

  }
    

  func getNewItems(currentListSize: Int){

    // fetch new list items
    infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)

  }
  
  func updateListItems(newList: [SerieData]?){
    if newList != nil && !newList!.isEmpty{
      // append new lists to the bottom of the list we already have
        self.viewUpdate?.appendData(list: newList)
    }
  }
  
}
