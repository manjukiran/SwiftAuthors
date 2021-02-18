//
//  CommitListViewModel.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

class CommitListViewModel: GenericViewModel {
    
    var commitList = CommitList()
    var filteredCommitList = CommitList()
    var searchString = ""
    let dataSyncManager: DataSyncManager

    required init(networkDataManager: URLDataFetching) {
        self.dataSyncManager = DataSyncManager(networkDataUtility: networkDataManager)
    }
    
    func count() -> Int {
        return searchString.isEmpty ? commitList.count : filteredCommitList.count
    }
    
    func objectAtIndex(index: Int) -> CommitElement {
        return searchString.isEmpty ? commitList[index] : filteredCommitList[index]
    }
    
    private func refreshContent(contentArray: CommitList) {
        self.commitList.removeAll()
        self.commitList.append(contentsOf: contentArray)
    }
    
    /// Searches and filters the list of colleagues for the search string
    /// - Parameter searchString: string for search
    /// - Parameter completion: closure block to handle the completion of search (to reload table vies for example)
    func searchForText(searchString: String, completion: @escaping () -> Void){
        self.searchString = searchString.lowercased()
        if searchString.count > 0 {
            self.filteredCommitList =  self.commitList.filter {
                ($0.commit.author.name.lowercased()).contains(self.searchString) ||
                    ($0.commit.message.lowercased()).contains(self.searchString)
                // Expand this functionality to add more params in search
            }
            completion()
        } else {
            completion()
            
        }
    }
   
}

extension CommitListViewModel: AuthorListFetcher {
    
    func retrieveCommitList(completion: @escaping genericDataFetchHandler<CommitList>) {
        let completionBlock:genericDataFetchHandler<CommitList> = { [weak self] (result) in
            switch result{
            case .success (let response):
                self?.refreshContent(contentArray: response)
            case .failure (let error):
                print(error)
            }
            completion(result)
        }
        if let urlString = APIEndpoint.commitList.urlString() {
            self.dataSyncManager.retrieveData(urlString: urlString, completion: completionBlock)
        } else {
            assertionFailure("Unable to construct commitList URL")
        }
    }
    
    func retrieveImageForAuthor(author: Committer, completion: @escaping imageHandler) {
        self.dataSyncManager.retrieveImageData(urlString: author.avatarURL, completion: completion)
    }
    
}
