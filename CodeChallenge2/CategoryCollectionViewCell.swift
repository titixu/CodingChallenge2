//
//  CategoryCollectionViewCell.swift
//  CodeChallenge2
//
//  Created by SamXu on 16/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let itemImageView: UIImageView = {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "loading"))
        
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel(frame: CGRect.zero)
        
        label.text = NSLocalizedString("Title", comment: "Media title default text")
        
        label.font = UIFont.systemFont(ofSize: 11.0, weight: UIFontWeightRegular)
        
        label.numberOfLines = 0
        
        label.isAccessibilityElement = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func defaultMediaItemImageSize() -> CGSize {
        
        return ViewGeometricConstants.mediaItemImageViewSize
    }
    
    func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(itemImageView)
        
        addSubview(titleLabel)
        
        // image view layout
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        itemImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        itemImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        itemImageView.widthAnchor.constraint(equalToConstant: defaultMediaItemImageSize().width).isActive = true
        
        itemImageView.heightAnchor.constraint(equalToConstant: defaultMediaItemImageSize().height).isActive = true
        
        // title label layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: ViewGeometricConstants.meditaItemCellTitleSpace).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let selectedBackgroundView = UIView(frame: bounds)
        
        selectedBackgroundView.backgroundColor = UIColor.lightGray
        
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    func resetImageToDefault() {
        
        itemImageView.image = #imageLiteral(resourceName: "loading")
    }
    
}

class CategoryFeaturedCollectionViewCell: CategoryCollectionViewCell {
    
    override func defaultMediaItemImageSize() -> CGSize {
        
        return ViewGeometricConstants.featuredMediaItemImageSize
    }
}
