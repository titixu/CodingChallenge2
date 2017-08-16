//
//  CategoryCollectionViewModel.swift
//  CodeChallenge2
//
//  Created by SamXu on 16/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation
import UIKit

class CategoryCollectionViewModel {
    
    var category: Category
    var thumbnailSize = ViewGeometricConstants.featuredMediaItemImageSize
    
    init(category: Category) {
        self.category = category
    }
    
    func isFeatured() -> Bool {
        
        return category.isFeatured
    }
    
    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        return category.items.count
    }
    
    func titleForIndexPath(_ indexPath: IndexPath) -> String {
        
        let item = category.items[indexPath.row]
        
        return NSLocalizedString( item.title, comment: "Category item title")
    }
    
    func sizeForItemAtIndexPath(indexPath: IndexPath) -> CGSize {
        
        if category.isFeatured {
            
            return ViewGeometricConstants.featuredMediaItemCellSize
            
        } else {
            
            return ViewGeometricConstants.mediaItemCellSize
        }
    }
    
    func loadImageAtIndexPath(_ indexPath: IndexPath,  callback: @escaping (UIImage?, IndexPath) -> Swift.Void) {

        let imageCollection = category.items[indexPath.row].imageCollection
        
        if let url = isFeatured() ? imageCollection.landscapeURL : imageCollection.portraitURL {
            
            let imageFetcher = ImageFetcher(imageURL: url)
            
            if isFeatured() {
                //get the thumbnail image instead of original image for better user scrolling expience
                imageFetcher.fetchThumbnailVerionImageWith(thumbnailSize, completionHandler: { (image:UIImage?, _) in
                    
                    callback(image, indexPath)
                })
                
            } else {
                
                imageFetcher.fetchImage(completionHandler: { (image: UIImage?, _) in
                    
                    callback(image, indexPath)
                })
            }
            
        } else {
            
            //return the missing image if no image url
            callback(#imageLiteral(resourceName: "missing"), indexPath)
        }
    }
}
