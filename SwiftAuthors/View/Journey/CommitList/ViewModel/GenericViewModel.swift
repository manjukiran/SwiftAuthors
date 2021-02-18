//
//  GenericViewModel.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation
import UIKit

/// Generic View Model Protocols
protocol GenericViewModel  {

    /// Required INIT function
    ///
    /// - Parameter dataSyncManager: data sync manager to allow fetching data from network APIs
    init(networkDataManager: URLDataFetching)
    
    /// Returns count of objects contained in the view model (useful for when acting as datasource for tableViews)
    ///
    /// - Returns: Count of objects
    func count() -> Int
    
}

protocol AuthorListFetcher {
    
    /// Retrieves the list of commits to be displayed
    ///
    /// - Parameter completion: handler for completion
    func retrieveCommitList(completion: @escaping genericDataFetchHandler<CommitList>)
    
    /// Retrives the image for the author in context
    ///
    /// - Parameters:
    ///   - author: Committer object to fetch image for
    ///   - completion: handler for completion
    func retrieveImageForAuthor(author: Committer, completion: @escaping imageHandler) 
}

