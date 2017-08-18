//
//  DetailViewModel.swift
//  CodeChallenge2
//
//  Created by SamXu on 17/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel {
    
    let item: MediaItem
    
    init(item: MediaItem) {
        
        self.item = item
    }
    
    func title() -> String {
        
        return NSLocalizedString(item.title, comment: "Media item detail view title")
    }
    
    func fetchImage(callback: @escaping (UIImage?) -> Swift.Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = self.item.imageCollection.landscapeURL {
                
                let imageFetcher = ImageFetcher(imageURL: url)
                
                imageFetcher.fetchImage(completionHandler: { (image: UIImage?, url: URL) in
                    callback(image)
                })
                
            } else {
                
                callback(#imageLiteral(resourceName: "missing"))
            }
        }
    }

    func year() -> String {
        
        return NSLocalizedString(String(item.year), comment: "Media item detail view year")
    }
    
    func theDescription() -> String {
        
        return NSLocalizedString(item.description, comment: "Media item detail view description")
    }
}
