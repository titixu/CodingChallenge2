//
//  HomeViewModel.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    private let catagoryURL = URL(string: "https://pastebin.com/raw/8LiEHfwU")!
    
    private var categorys = [Category]()
    
    private lazy var objectFetcher: ObjectFetcher = {
        
        ObjectFetcher(url: self.catagoryURL)
    }()
    
    func loadData(completionHandler: @escaping (Error?) -> ()) {
        
        objectFetcher.fetch { (data: Data?, error: Error?) in
            
            if let error = error {
                
                completionHandler(error)
                
                return
            }
            
            if let data = data {
                
                do {
                    
                    let jsons = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [JSON]
                    
                    self.categorys = [] // clean up old categorys data
                    
                    for json in jsons {
                        
                        let category = try Category(json: json)
                        
                        // Feature category always at the top
                        if category!.isFeatured == true {
                            
                            self.categorys.insert(category!, at: 0)
                            
                        } else {
                            
                            self.categorys.append(category!)
                        }
                        
                    }
                    
                } catch {
                    
                    completionHandler(error)
                    
                    return
                }
                
            }
            
            completionHandler(error)
        }
        
    }
    
    // MARK: - TableView Data Source
    
    func numberOfSection() -> Int {
        
        return categorys.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        
        return 1
    }
    
    func titleForSectionHeader(_ section: Int) -> String {
        
        let category = categorys[section]
        
        return NSLocalizedString(category.title, comment: "Home table view section title")
    }
    
    func heightForRowAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        
        let category = categorys[indexPath.section]
        
        if category.isFeatured {
            
            return ViewGeometricConstants.featuredCategoryCellHeight
            
        } else {
            
            return ViewGeometricConstants.categoryCellHeight
        }
    }
    
    func categoryCollectionViewControllerAtIndexPath(_ indexPath: IndexPath) -> CategoryCollectionViewController {
        
        let category = categorys[indexPath.section]
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.minimumInteritemSpacing = ViewGeometricConstants.minimumInteritemSpacing
        
        layout.minimumLineSpacing = ViewGeometricConstants.minimumLineSpacing
        
        let viewController = CategoryCollectionViewController(collectionViewLayout: layout)
        
        viewController.viewModel = CategoryCollectionViewModel(category: category)
        
        return viewController
    }
}
