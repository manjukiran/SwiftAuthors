//
//  CommitElementTest.swift
//  SwiftAuthorsTests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest
@testable import SwiftAuthors

class CommitElementTest: XCTestCase {

    var commitElement: CommitElement!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.commitElement = try? JSONUtlity.decodeSingleCommitFromJson()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testName() {
        XCTAssertEqual(self.commitElement.commit.author.name, "Saleem Abdulrasool")
    }
    
    func testDescription() {
        XCTAssertEqual(self.commitElement.commit.message, "test: make `%target-library-name` work in captures\n\nThanks to @jrose for the hint about the substitution ordering, the new\nsubstitution now works even inside the capture group.  Replace the\nremaining uses to the new macro.")
    }
    
    func testImageURL() {
        XCTAssertEqual(self.commitElement.committer.avatarURL, "https://avatars.githubusercontent.com/u/63311?v=4")
    }    

}
