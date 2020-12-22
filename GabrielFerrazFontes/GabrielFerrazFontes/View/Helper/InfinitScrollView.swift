//
//  InfiniteScrollView.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import SwiftUI
import RxSwift

/**
 Infinite Scroll View
 */
struct InfiniteScrollView: View {

    /// reference of core data managed object
    @Environment(\.managedObjectContext) private var viewContext
    /// Observed Object which holds the array of series to populate the list with.
    @ObservedObject var myList = ObservableArray<SerieData>(array: [SerieData(id: 0, name: "aaa", posterPath: "", overview: "bbbb", voteAverage: 8.0, voteCount: 2, genres: [SerieGenre(id: 0, name: "Drama")])])
        
    /// reference of view model
    let viewModel = InfiniteScrollViewModel()

    init() {
        // pass viewupdateprotocol to viewmodel
        self.viewModel.viewUpdate = self
    }
    
    var body: some View {
        
        List (self.myList.array.enumerated().map({ $0 }), id: \.1.self.id) { (index,serie) in
            
            ScrollViewCell(serie: serie)
                .environment(\.managedObjectContext, viewContext)
                .onAppear(perform: {
                let count = self.myList.array.count
                if index == count - 1 {
                    // request for more data since last row has being reached
                    self.viewModel.getNewItems(currentListSize: count)
                }
            })
        }
    }
}

extension InfiniteScrollView: ViewUpdateProtocol{
    func appendData(list: [SerieData]?) {
        self.myList.array.append(contentsOf: list!)
    }

}

/**
 Delegate to comunicate view model with view
 */
protocol ViewUpdateProtocol{
    /**
     append more data to array
     */
    func appendData(list: [SerieData]?)
}

struct InfiniteScrollView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScrollView()
  }
  
}
