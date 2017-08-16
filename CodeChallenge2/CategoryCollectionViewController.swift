//
//  CategoryCollectionViewController.swift
//  CodeChallenge2
//
//  Created by SamXu on 16/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

private let cellIdentifier = "CategoryCollectionCell"
private let featuredCellIndetifier = "CategoryFeaturedCollectionViewCell"

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var viewModel: CategoryCollectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup collection view
        clearsSelectionOnViewWillAppear = false
        
        collectionView!.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView!.register(CategoryFeaturedCollectionViewCell.self, forCellWithReuseIdentifier: featuredCellIndetifier)
        
        collectionView!.showsVerticalScrollIndicator = false
        
        collectionView!.alwaysBounceHorizontal = true
        
        collectionView!.backgroundColor = UIColor.white
        
        collectionView!.contentInset.left = ViewGeometricConstants.contentInsetLeft
    }

    // MARK:- UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return viewModel.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.numberOfItems(inSection: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = viewModel.isFeatured() ? featuredCellIndetifier : cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.titleLabel.text = viewModel.titleForIndexPath(indexPath)
        
        viewModel.loadImageAtIndexPath(indexPath) { (image: UIImage?, indexPathOfImage: IndexPath) in
            
            //alway update UI in main queue
            DispatchQueue.main.async {
                
                cell.itemImageView.image = image
            }
        }
        
        return cell
    }
    
    // MARK:- UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }

    // MARK:- UICollectionViewDelegateFlowLayout 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return viewModel.sizeForItemAtIndexPath(indexPath: indexPath)
    }
}
