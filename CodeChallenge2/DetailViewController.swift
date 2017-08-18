//
//  DetailViewController.swift
//  CodeChallenge2
//
//  Created by SamXu on 17/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel!
    
    open weak var delegate: DetailViewControllerDelegate?
    
    let contentView = DetailView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let spacing = ViewGeometricConstants.stackViewSpace
        
        view.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + ViewGeometricConstants.stackViewTopSpace).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spacing).isActive = true
        
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing).isActive = true
        
        contentView.titleLabel.text = viewModel.title()
        
        contentView.yearLabel.text = viewModel.year()
        
        contentView.descriptionLabel.text = viewModel.theDescription()
        
        viewModel.fetchImage { [weak self] (image: UIImage?) in
            
            DispatchQueue.main.async {
                
                self?.contentView.imageView.image = image
            }
            
        }
        
        contentView.closeButton.addTarget(self, action: #selector(closeButton(sender:)), for: .touchUpInside)
    }
    
    @objc func closeButton(sender: Any) {
        
        if let delegate = delegate {
            
            delegate.detailViewControllerDidClickCloseButton(self)
        }
    }
}

protocol DetailViewControllerDelegate: NSObjectProtocol {
    
    func detailViewControllerDidClickCloseButton(_ viewController: DetailViewController)
}
