//
//  AllSeriesView.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import SwiftUI

/**
 Root View, presents all series
 */
struct AllSeriesView: View {
    
    /// reference of core data managed object
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FavoritesSeriesView()) {
                    Text("Favoritos")
                }
                
                InfiniteScrollView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .navigationBarHidden(true)
        }
    }
}

struct AllSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        AllSeriesView()
    }
}
