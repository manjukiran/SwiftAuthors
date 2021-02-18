//
//  CommitDetailsViewControllerTests.swift
//  SwiftAuthorsTests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest
@testable import SwiftAuthors

class CommitDetailsViewControllerTests: XCTestCase {
    
    private var rootViewController: CommitDetailsViewController!
    private var topLevelUIUtilities: TopLevelUIUtilities<CommitDetailsViewController>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let commitElement = try? JSONUtlity.decodeSingleCommitFromJson() else { XCTFail() ;
            return }
        let myViewController = CommitDetailsViewController.create(commitElement)
        rootViewController = myViewController
        topLevelUIUtilities = TopLevelUIUtilities<CommitDetailsViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: rootViewController)
    }
    
    override func tearDown() {
        rootViewController = nil
        topLevelUIUtilities.tearDownTopLevelUI()
        topLevelUIUtilities = nil
        super.tearDown()
    }
    
    func test_load_commitDetails_success() {
        let expectation = XCTestExpectation()
        UIView.runOnMainThread {
            XCTAssertEqual(rootViewController.authorNameLabel.text, "Saleem Abdulrasool")
            XCTAssertEqual(rootViewController.commitMessageLabel.text, ("test: make `%target-library-name` work in captures\n\nThanks to @jrose for the hint about the substitution ordering, the new\nsubstitution now works even inside the capture group.  Replace the\nremaining uses to the new macro."))
            XCTAssertNotNil(rootViewController.authorImageView)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    
}
