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

protocol CategoryCollectionViewControllerDelegate: NSObjectProtocol {
    
    func categoryCollectionViewController(_ collectionViewController: CategoryCollectionViewController, didClickOnItem mediaItemViewModel: DetailViewModel)
}

class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var viewModel: CategoryCollectionViewModel!
    
    weak open var delegate: CategoryCollectionViewControllerDelegate?
    
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

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let indexPaths = collectionView!.indexPathsForSelectedItems {
            
            for indexPath in indexPaths {
                
                collectionView?.deselectItem(at: indexPath, animated: true)
            }
        }
        
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
        
        cell.resetImageToDefault() //reset the image first, and load the image at "collection view cell willDisplay" delegate method
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let aCell = cell as! CategoryCollectionViewCell
        
        viewModel.loadImageAtIndexPath(indexPath) { (image: UIImage?, indexPathOfImage: IndexPath) in
            
            //alway update UI in main queue
            DispatchQueue.main.async {
                
                    aCell.itemImageView.image = image
            }
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewModel = viewModel.detailViewModelForIndexPath(indexPath: indexPath)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let delegate = delegate {
            
            delegate.categoryCollectionViewController(self, didClickOnItem: detailViewModel)
            
        }        
    }
    
    // MARK:- UICollectionViewDelegateFlowLayout 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return viewModel.sizeForItemAtIndexPath(indexPath: indexPath)
    }
}
