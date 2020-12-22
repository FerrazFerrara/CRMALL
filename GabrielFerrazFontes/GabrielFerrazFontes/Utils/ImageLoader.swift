//
//  ImageLoader.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 21/12/20.
//

import SwiftUI
import UIKit

/// Image saved at cache
private let _imageCache = NSCache<AnyObject, AnyObject>()

/**
 Class helper to load images based on their url
 */
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    /// reference of image cache
    var imageCache = _imageCache
    
    /**
     Load a image using their url
     
     - parameters:
        - url: url of image to be loaded
     */
    func loadImage(with url: URL){
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do{
                // cast from data to UIImage async
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
