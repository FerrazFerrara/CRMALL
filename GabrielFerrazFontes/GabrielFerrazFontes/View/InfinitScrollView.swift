//
//  InfiniteScrollView.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import SwiftUI
import RxSwift

struct InfiniteScrollView: View {

    @Environment(\.managedObjectContext) private var viewContext

    
    // an ObservedObject object which holds the array we populate our List with.
//    @ObservedObject var myList = ObservableArray<Serie>(array: [Serie(id: 0, name: "aaa", genders: ["drama"], poster_path: "", overview: "bbbb", voteAverage: 8.0, voteCount: 2, popularity: 9.0)])
    @ObservedObject var myList = ObservableArray<SerieData>(array: [SerieData(id: 0, name: "aaa", posterPath: "", overview: "bbbb", voteAverage: 8.0, voteCount: 2, genres: [SerieGenre(id: 0, name: "Drama")])])
        
    //initialize ViewModel class which we will use to requests for data
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
                    print(count)
                    print(index)
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

protocol ViewUpdateProtocol{
    func appendData(list: [SerieData]?)
}

struct InfiniteScrollView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScrollView()
  }
  
}
