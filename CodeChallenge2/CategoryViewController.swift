//
//  CategoryViewController.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    let viewModel = CategoryViewModel()
    let loadingIndicator = CenteredBlueActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        viewModel.loadData { (error: Error?) in
            if let error = error {
                displayAlert(message: error.localizedDescription)
            } else {
                tableView.reloadData()
            }
        }
    }

    //MARK: - UIs
    private func insertActivityIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate(loadingIndicator.defaultConstraints(superView: view))
    }
    
 
}

 
