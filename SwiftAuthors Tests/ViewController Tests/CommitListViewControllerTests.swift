//
//  CommitListViewControllerTests.swift
//  SwiftAuthorsTests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest
@testable import SwiftAuthors

class CommitListViewControllerTests: XCTestCase {
    private var rootViewController: CommitListViewController!
    private var topLevelUIUtilities: TopLevelUIUtilities<CommitListViewController>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let commitListData = try? JSONUtlity.commitListJSONData() else {
            XCTFail()
            return
        }
        let dataFetcher = NetworkMockUtility.SuccessfulNetworkFetch(data: commitListData)
        let commitListViewModel = CommitListViewModel(networkDataManager: dataFetcher)
        commitListViewModel.retrieveCommitList { (_) in }
        let myViewController = CommitListViewController.create(commitListViewModel)
        rootViewController = myViewController
        topLevelUIUtilities = TopLevelUIUtilities<CommitListViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: rootViewController)
    }
    
    override func tearDown() {
        rootViewController = nil
        topLevelUIUtilities.tearDownTopLevelUI()
        topLevelUIUtilities = nil
        super.tearDown()
    }
    
    func test_load_commitList_success() {
        let expectation = XCTestExpectation()
        UIView.runOnMainThread {
            XCTAssertEqual(rootViewController.tableView.numberOfRows(inSection: 0),
                           100)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCell() {
        sleep(3)
        let expectation = XCTestExpectation()
        UIView.runOnMainThread {
            let cell = rootViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! CommitCell
            let commitElement = rootViewController.commitListViewModel?.objectAtIndex(index: 0)
            XCTAssertEqual(cell.nameLabel.text, commitElement?.commit.author.name)
            XCTAssertEqual(cell.commitMessageLabel.text, commitElement?.commit.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        
    }
    
}
