//
//  ObservableArray.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import Combine

/**
 Make Array entiry observable
 */
class ObservableArray<T>: ObservableObject {

  var cancellables = [AnyCancellable]()
  
  @Published var array:[T] = []
  
  init(array: [T])  {
    self.array = array
  }
  
  func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
   }
}
