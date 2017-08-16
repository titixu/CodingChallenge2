//
//  HomeViewController.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let viewModel = CategorysViewModel()
    
    let loadingIndicator = CenteredBlueActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        insertActivityIndicator()
        
        addRefreshControl()
        
        refresh()
    }
    
    //MARK: - UIs
    private func insertActivityIndicator() {
        
        tableView.addSubview(loadingIndicator)
        
        loadingIndicator.activateDefaultConstraints(superView: tableView!)
    }
    
    //MARK: - Private methods
    @objc private func refresh() {
        
        loadingIndicator.startAnimating()
        
        viewModel.loadData {[weak self] (error: Error?) in
            DispatchQueue.main.async {
                
                self?.loadingIndicator.stopAnimating()
                
                self?.refreshControl?.endRefreshing()
                
                if let error = error {
                    
                    self?.displayAlert(message: error.localizedDescription)
                    
                } else {
                    
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
    }
    
}

 