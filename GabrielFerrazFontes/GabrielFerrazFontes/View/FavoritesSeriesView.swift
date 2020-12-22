//
//  FavoritesSeriesView.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import SwiftUI

struct FavoritesSeriesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var series: [SerieData] = []
    
    let viewModel = FavoritesSeriesViewModel()
    
    var body: some View {
        List(series) { serie in
            ScrollViewCell(serie: serie)
        }.onAppear {
            series = viewModel.fetchData(viewContext: viewContext)
        }
    }
}

struct FavoritesSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSeriesView()
    }
}
