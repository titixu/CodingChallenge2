//
//  DetailView.swift
//  CodeChallenge2
//
//  Created by SamXu on 17/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let titleLabel: UILabel = {
        
        let label = UILabel(frame: CGRect.zero)
        
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isAccessibilityElement = true
        
        return label
    }()
    
    let imageView: UIImageView = {
        
        let imageview = UIImageView(image: #imageLiteral(resourceName: "loading"))
        
        imageview.contentMode = .scaleAspectFit
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        imageview.clipsToBounds = true
        
        imageview.layer.borderColor = UIColor.gray.cgColor
        
        imageview.layer.borderWidth = 1.0
        
        return imageview
    }()
    
    let yearLabel: UILabel = {
        
        let label = UILabel(frame: CGRect.zero)
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isAccessibilityElement = true
        
        return label
        
    }()
    
    let descriptionLabel: UILabel = {
        
        let label = UILabel(frame: CGRect.zero)
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        label.numberOfLines = 0 //set to zero for unlimit of lines
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.isAccessibilityElement = true
        
        return label
        
    }()
    
    let closeButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setTitle("X", for: .normal)
        
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isAccessibilityElement = true
        
        button.accessibilityLabel = "Close Button"
        
        return button
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //top stack view for the title label and the close button
        let topStackView = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.axis = .horizontal
        
        topStackView.spacing = ViewGeometricConstants.stackViewSpace
        
        topStackView.distribution = .fillProportionally
        
        topStackView.backgroundColor = UIColor.red
        
        // whole stack view for the view
        let bodyStackView = UIStackView(arrangedSubviews: [topStackView, imageView, yearLabel, descriptionLabel])
        
        bodyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bodyStackView.axis = .vertical
        
        bodyStackView.distribution = .fillProportionally
        
        addSubview(bodyStackView)
        
        // stack view anchors to full screen of view
        bodyStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        bodyStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        bodyStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        bodyStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //top stack view should have the full width to bodyStackView
        topStackView.leftAnchor.constraint(equalTo: bodyStackView.leftAnchor).isActive = true
        
        topStackView.rightAnchor.constraint(equalTo: bodyStackView.rightAnchor).isActive = true
        
        // Fix size for the close button
        closeButton.widthAnchor.constraint(equalToConstant: ViewGeometricConstants.closeButtonSize.width).isActive = true
        
        closeButton.heightAnchor.constraint(equalToConstant: ViewGeometricConstants.closeButtonSize.height).isActive = true
        
        // Fix heigt for year label and description label
        yearLabel.heightAnchor.constraint(equalToConstant: ViewGeometricConstants.labelHeightNormal).isActive = true
        
        descriptionLabel.heightAnchor.constraint(equalToConstant: ViewGeometricConstants.labelHeightTall).isActive = true
        
    }
    
}
