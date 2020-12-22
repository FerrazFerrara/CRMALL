//
//  ScrollViewCell.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import Foundation
import SwiftUI

struct ScrollViewCell: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var serie: SerieData
    @ObservedObject var imageLoader = ImageLoader()
    
    let viewModel = ScrollCellViewModel()
    
    var body: some View {
        HStack {
            
            Image(uiImage: getImage(serie: serie))
                .resizable()
                .frame(width: 95, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onAppear {
                    self.imageLoader.loadImage(with: (serie.posterURL ?? URL(string: "https://image.tmdb.org/t/p/w500/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg"))!)
                }
            
            
            VStack {
                Text(serie.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
//                Text("\(serie.genders[0]) \n\(serie.overview) \n\(String(format: "%.1f", serie.voteAverage))/10.0 ● \(serie.voteCount) votos")
                Text("\(serie.genreString)\n\(serie.overview)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                Text("\(String(format: "%.1f", serie.voteAverage))/10.0 ● \(serie.voteCount) votos")
                    .font(.footnote)
                
                
//                Text("")
//                    .font(.body)
                
                Spacer()
                
//                HStack {
//                    Text(serie.voteAverage)
//                }
            }
            
//            VStack {
//                Text(serie.name)
//                Spacer()
//                Text(serie.genders[0])
//                Spacer()
//                Text(serie.overview)
//                Spacer()
//
//                HStack {
//                    Text(serie.voteAverage)
//                    Spacer()
//                    Text(serie.voteCount)
//                }
//
//            }
            
            Spacer()
            
            Button(action: {
                viewModel.favoriteNewSerie(context: viewContext, serie: serie)
            }, label: {
                Text("❤️")
            })
        }
    }
    
    func getImage(serie: SerieData) -> UIImage {
        let defaultImage = UIImage(named: "defaultPoster")!
        
        guard let url = serie.posterURL else { return defaultImage }
        guard let data = try? Data(contentsOf: url) else { return defaultImage }
        guard let image = UIImage(data: data) else { return defaultImage }
        
        return image
    }
    
}
