//
//  ScrollViewCell.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import SwiftUI

/**
 Scroll View Cell
 */
struct ScrollViewCell: View {
    
    /// reference of core data managed object
    @Environment(\.managedObjectContext) private var viewContext
    /// serie of this cell
    @State var serie: SerieData
    /// image loader
    @ObservedObject var imageLoader = ImageLoader()
    
    /// reference to viewModel
    let viewModel = ScrollCellViewModel()
    
    var body: some View {
        HStack {
            
            Image(uiImage: getImage())
                .resizable()
                .frame(width: 95, height: 150, alignment: .center)
                .onAppear {
                    self.imageLoader.loadImage(with: (serie.posterURL ?? URL(string: "https://image.tmdb.org/t/p/w500/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg"))!)
                }
            
            
            VStack {
                Text(serie.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Text("\(serie.genreString)\n\(serie.overview)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                if serie.voteCount != 0 {
                    Text("\(String(format: "%.1f", serie.voteAverage))/10.0 ● \(serie.voteCount) votos")
                        .font(.footnote)
                }
                
                Spacer()
            }
            
            Spacer()
            
            if serie.voteCount != 0 {
                Button(action: {
                    viewModel.favoriteNewSerie(context: viewContext, serie: serie)
                }, label: {
                    Text("♡")
                })
            }
        }
    }
    
    /**
     Initialize a Image
     */
    func getImage() -> UIImage {
        let defaultImage = UIImage(named: "defaultPoster")!

        guard let url = self.serie.posterURL else { return defaultImage }
        guard let data = try? Data(contentsOf: url) else { return defaultImage }
        guard let image = UIImage(data: data) else { return defaultImage }

        return image
    }
    
}
