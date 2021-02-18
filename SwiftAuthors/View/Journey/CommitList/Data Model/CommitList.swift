//
//  CommitList.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

typealias CommitList = [CommitElement]

// MARK: - WelcomeElement
struct CommitElement: Codable {
    let sha: String
    let nodeID: String
    let commit: Commit
    let url: String
    let htmlURL: String
    let commentsURL: String
    let author: Committer?
    let committer: Committer
    let parents: [Parent]

    enum CodingKeys: String, CodingKey {
        case sha
        case nodeID = "node_id"
        case commit, url
        case htmlURL = "html_url"
        case commentsURL = "comments_url"
        case author, committer, parents
    }
}

// MARK: - Commit
struct Commit: Codable {
    let author: Author
    let committer: Author
    let message: String
    let tree: Tree
    let url: String
    let commentCount: Int
    let verification: Verification

    enum CodingKeys: String, CodingKey {
        case author, committer, message, tree, url
        case commentCount = "comment_count"
        case verification
    }
}

// MARK: - Parent
struct Parent: Codable {
    let sha: String
    let url: String
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case sha, url
        case htmlURL = "html_url"
    }
}

