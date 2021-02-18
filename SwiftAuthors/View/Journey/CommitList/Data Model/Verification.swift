//
//  Verification.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//


// MARK: - Verification
struct Verification: Codable {
    
    enum Reason: String, Codable {
        case unsigned = "unsigned"
        case valid = "valid"
    }
    
    let verified: Bool
    let reason: Reason
    let signature: String?
    let payload: String?
}



