//
//  CommitListViewController.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

class CommitListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var commitListViewModel: CommitListViewModel?
    var isDataFetchInProgress = false
    
    /// Function to instantiate view controller with dependency injection of a view model;
    /// this approach is used for VCs instantiated from the storyboard
    ///
    /// - Parameter CommitListViewModel: view model object to act as the data source
    /// - Returns: CommitListViewController object
    class func create(_ commitListViewModel: CommitListViewModel) -> CommitListViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: CommitListViewController.storyboardIdentifier) as? CommitListViewController {
            vc.commitListViewModel = commitListViewModel
            return vc
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "commit_list_view_title".localized()
        self.searchBar.delegate = self
        if self.commitListViewModel == nil {
            self.commitListViewModel = CommitListViewModel(networkDataManager: NetworkDataUtility.shared)
        }
        self.configureTableView()
        self.refreshCommitListData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCommitListData),
                                               name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc private func refreshCommitListData() {
        self.isDataFetchInProgress = true
        self.tableView.refreshControl?.beginRefreshing()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.commitListViewModel?.retrieveCommitList(completion: { [weak self] (result) in
                self?.isDataFetchInProgress = false
                UIView.runOnMainThread { [weak self] in
                    self?.tableView.refreshControl?.endRefreshing()
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    private func configureTableView() {
        self.configureRefreshControl()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 120.0
        self.tableView.register(cell: PlaceHolderCell.self, nibName: PlaceHolderCell.reuseIdentifier)
    }
    
    private func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = AppTheme.themeColor
        refreshControl.attributedTitle = NSAttributedString(string: "updating_commit_list_data_message".localized())
        refreshControl.addTarget(self, action: #selector(refreshCommitListData), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
}

extension CommitListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.commitListViewModel?.searchForText(searchString: searchBar.text ?? "",
                                              completion: { [weak self] in
                                                self?.tableView.reloadOnMainThread()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.commitListViewModel?.searchForText(searchString: searchText,
                                              completion: { [weak self] in
                                                self?.tableView.reloadOnMainThread()
        })
    }
}

extension CommitListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let commitListViewModel = self.commitListViewModel {
            return commitListViewModel.count() > 0 ? commitListViewModel.count() : 1 // Placeholder
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let commitListViewModel = self.commitListViewModel, commitListViewModel.count() > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommitCell.reuseIdentifier,
                                                        for: indexPath) as? CommitCell {
                let commit = commitListViewModel.objectAtIndex(index: indexPath.row)
                cell.configureWithCommit(commit: commit, searchText: searchBar.text)
                /// The following code retrieves image from the backend/cache and applies it to the cell ONLY if the cell is still visible
                let author = commit.author ?? commit.committer // Fallback
                commitListViewModel.retrieveImageForAuthor(author: author) { [weak self] result in
                    switch result{
                    case .success(let image):
                        UIView.runOnMainThread {
                            let visibleIndexPaths = self?.tableView.indexPathsForVisibleRows
                            if (visibleIndexPaths?.contains(indexPath) ?? false) {
                                cell.configureImage(image: image)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                return cell
            }
        }
        
        // Placeholder cell when no data is received from the backend
        else if let cell = tableView.dequeueReusableCell(withIdentifier: PlaceHolderCell.reuseIdentifier,
                                                    for: indexPath) as? PlaceHolderCell {
            let imageName = self.isDataFetchInProgress ? "planet_icon" : "no_data_icon"
            var placeHolderText = ""
            if self.isDataFetchInProgress {
                placeHolderText = "data_fetch_in_progress"
            } else {
                placeHolderText = (self.searchBar.text?.count ?? 0 > 0) ? "no_results_placeholder_message" : "no_data_placeholder_message"
            }
            cell.configureCell(imageName: imageName, text: placeHolderText.localized())
            return cell
        }
        return UITableViewCell()
    }
    
}

extension CommitListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = self.commitListViewModel,
           viewModel.count() > 0 {
            let commitElement = viewModel.objectAtIndex(index: indexPath.row)
            if let vc = CommitDetailsViewController.create(commitElement) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}
