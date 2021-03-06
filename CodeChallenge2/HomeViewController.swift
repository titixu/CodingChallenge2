//
//  HomeViewController.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CategoryTableViewCell"

class HomeViewController: UITableViewController, CategoryCollectionViewControllerDelegate, DetailViewControllerDelegate {
    
    // For custom view controller transitioning animation
    private let transistionDelegate = HomeViewControllerTransition()
    
    private let viewModel = HomeViewModel()
    
    private let loadingIndicator = CenteredBlueActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTableView()
        
        insertActivityIndicator()
        
        addRefreshControl()
        
        refresh()
    }
    
    // MARK: - UIs
    private func setupTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorStyle = .none
        
        tableView.separatorInset.left = ViewGeometricConstants.contentInsetLeft
        
        tableView.contentInset.top = UIApplication.shared.statusBarFrame.height
    }
    
    private func insertActivityIndicator() {
        
        tableView.addSubview(loadingIndicator)
        
        loadingIndicator.activateDefaultConstraints(superView: tableView!)
    }
    
    // MARK: - Private methods
    @objc private func refresh() {
        
        loadingIndicator.startAnimating()
        
        viewModel.loadData { [weak self] (error: Error?) in
            DispatchQueue.main.async {
                
                self?.loadingIndicator.stopAnimating()
                
                self?.refreshControl?.endRefreshing()
                
                if let error = error {
                    
                    self?.displayAlert(message: error.localizedDescription)
                    
                }
                
                self?.tableView.reloadData()
            }
        }
    }
    
    private func addRefreshControl() {
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        configCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    private func configCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        
        // clean up for reuse
        cell.subviews.forEach { view in
            
            if view is UICollectionView {
                
                view.removeFromSuperview()
            }
        }
        
        let viewController = viewModel.categoryCollectionViewControllerAtIndexPath(indexPath)
        
        viewController.delegate = self
        
        addChild(viewController)
        
        viewController.collectionView?.frame = cell.bounds
        
        cell.addSubview(viewController.collectionView!)
        
        viewController.didMove(toParent: self)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.titleForSectionHeader(section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel.heightForRowAtIndexPath(indexPath)
    }
    
    // MARK: - CategoryCollectionViewControllerDelegate
    func categoryCollectionViewController(_ collectionViewController: CategoryCollectionViewController, didClickOnItem mediaItemViewModel: DetailViewModel, withCellFrameInScreen frame: CGRect) {
        
        let detailViewController = DetailViewController(nibName: nil, bundle: nil)
        
        detailViewController.viewModel = mediaItemViewModel
        
        detailViewController.modalPresentationStyle = .fullScreen
        
        detailViewController.delegate = self
        
        detailViewController.transitioningDelegate = transistionDelegate
        
        transistionDelegate.originFrame = frame
        
        present(detailViewController, animated: true, completion: nil)
        
    }
    
    // MARK: - DetailViewControllerDelegate
    func detailViewControllerDidClickCloseButton(_ viewController: DetailViewController) {
        
        dismiss(animated: true, completion: nil)
    }
}
