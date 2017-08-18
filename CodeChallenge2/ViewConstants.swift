//
//  ViewConstants.swift
//  CodeChallenge2
//
//  Created by SamXu on 16/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

struct ViewGeometricConstants {
    
    // for image view in collection cell
    static let featuredMediaItemImageSize = CGSize(width: 200.0, height: 113.0)
    
    static let mediaItemImageViewSize = CGSize(width: 117.0, height: 175.0)
    
    // for collection view cell (image view + title label)
    static let featuredMediaItemCellSize = CGSize(width: 200.0, height: 158.0)
    
    static let mediaItemCellSize = CGSize(width: 117.0, height: 220.0)
    
    static let meditaItemCellTitleSpace: CGFloat = 4.0
    
    // for table view cell height
    static let categoryCellHeight: CGFloat = 220.0
    
    static let featuredCategoryCellHeight: CGFloat = 170.0
    
    // for collection flow layout
    static let minimumInteritemSpacing: CGFloat = 8.0
    
    static let minimumLineSpacing: CGFloat = 8.0

    // for any content inset
    static let contentInsetLeft: CGFloat = 8.0
    
    // For stack views in Detail view controller
    static let stackViewSpace: CGFloat = 8.0
    
    // bit more space at the top
    static let stackViewTopSpace: CGFloat = 8.0
    
    // close button
    static let closeButtonSize: CGSize = CGSize(width: 40.0, height: 40.0)
    
    // normal label height
    static let labelHeightNormal: CGFloat = 30.0
    
    // tall label height
    static let labelHeightTall: CGFloat = 92.0
}
