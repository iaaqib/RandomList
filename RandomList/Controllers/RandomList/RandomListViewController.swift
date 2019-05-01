//
//  RandomListViewController.swift
//  RandomList
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import UIKit
import Toast_Swift

class RandomListViewController: UITableViewController {
    
    // MARK: - Vars
   
    @IBOutlet private weak var searchBar: UISearchBar!
    let refControl = UIRefreshControl()
    let viewModel = RandomListViewModel()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModelCallbacks()
        setupUI()
        viewModel.fetchProducts()
    }
    
    // MARK: - Functions
    
    private func setupViewModelCallbacks() {
        
        //Shows or hides loader and enable/disables the button
        viewModel.displayActivityIndicator = { [weak self] state in
            
            if state {
                self?.view.makeToastActivity(.center)
            } else {
                self?.view.hideToastActivity()
            }
        }
        
        //loads the data
        viewModel.reloadData = { [weak self]  in
            
            self?.tableView.reloadData()
            self?.refControl.endRefreshing()
        }
        
        //Shows any error message
        viewModel.displayMessage = { [weak self] message in
            
            self?.view.makeToast(message, duration: 1, position: .center)
        }
        
    }
    
    private func setupUI() {
        navigationController?.hidesBarsOnSwipe = true
        refreshControl = refControl
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    
    @objc func pullToRefresh() {
        viewModel.getRandomProducts()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ImagePreviewViewController
        let url = sender as? URL
        destination.previewImageURL = url
    }
    
}

extension RandomListViewController {
    
    // MARK: - TableViewDataSource & Delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RandomListTableViewCell.className, for: indexPath) as! RandomListTableViewCell
        let model = viewModel.getItemAtIndex(index: indexPath.row)
        cell.populateCell(model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.getItemAtIndex(index: indexPath.row).image?.asURL
        performSegue(withIdentifier: ImagePreviewViewController.className, sender: url)
    }
}

extension RandomListViewController: UISearchBarDelegate {
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchProductByName(text: searchText)
    }
}

