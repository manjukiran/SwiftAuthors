//
//  CommitListViewModel.swift
//  SwiftAuthorsTests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest
@testable import SwiftAuthors

class CommitListViewModelTests: XCTestCase {
    var commitListViewModel: CommitListViewModel!

    override func setUp() {
        guard let commitListData = try? JSONUtlity.commitListJSONData() else {
            XCTFail() ; return
        }
        let dataFetcher = NetworkMockUtility.SuccessfulNetworkFetch(data: commitListData)
        self.commitListViewModel = CommitListViewModel(networkDataManager: dataFetcher)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingCommitListDataFromBackend() {
        self.commitListViewModel.retrieveCommitList { [weak self] result in
            switch result{
            case .success(let response):
                XCTAssertTrue(self?.commitListViewModel.count() ?? 0 > 0)
                XCTAssertEqual(response.count, self?.commitListViewModel?.count())
            case .failure(_):
                XCTFail()
            }
        }
    }
       
    func testSearchForCommitName() {
        let searchString = "Groff"
        self.commitListViewModel.retrieveCommitList { [weak self] (result) in
            switch result{
            case .success(let response):
                XCTAssertTrue(self?.commitListViewModel.count() ?? 0 > 0)
                XCTAssertEqual(response.count, self?.commitListViewModel?.count())
                self?.commitListViewModel.searchForText(searchString: searchString.lowercased() , completion: {
                    XCTAssertEqual(self?.commitListViewModel.searchString, searchString.lowercased())
                    XCTAssertTrue(self?.commitListViewModel.count() ?? 0 == 8)
                })
            case .failure(_):
                XCTFail()
            }
        }
    }

}
