//
//  FavoritesSeriesView.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import SwiftUI

/**
 Screen of Favorites Series
 */
struct FavoritesSeriesView: View {
    
    /// reference of core data managed object
    @Environment(\.managedObjectContext) private var viewContext
    /// array of all series favorited
    @State private var series: [SerieData] = []
    
    /// reference of view model
    let viewModel = FavoritesSeriesViewModel()
    
    var body: some View {
        List(series) { serie in
            ScrollViewCell(serie: serie)
        }.onAppear {
            // getting data right after load this view
            series = viewModel.fetchData(viewContext: viewContext)
        }
    }
}

struct FavoritesSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSeriesView()
    }
}
