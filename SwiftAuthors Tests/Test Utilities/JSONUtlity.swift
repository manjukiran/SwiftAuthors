//
//  JSONUtlity.swift
//  SwiftAuthors Tests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest

@testable import SwiftAuthors

class JSONUtlity {
    
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        return decoder
    }()
    
    private static func dataFromJSONFile(named fileName: String) throws -> Data {
        return try FileUtility.data(forFileName: fileName, withExtension: "json")
    }
    
    static func commitListJSONData() throws -> Data {
        return try dataFromJSONFile(named: "CommitList")
    }
    
    static func singleCommitJSONData() throws -> Data {
        return try dataFromJSONFile(named: "1-Commit")
    }
        
    static func decodeCommitListFromJson() throws -> CommitList? {
        return try decoder.decode(CommitList.self, from: commitListJSONData())
    }
    
    static func decodeSingleCommitFromJson() throws -> CommitElement {
        return try decoder.decode(CommitElement.self, from: singleCommitJSONData())
    }
}
