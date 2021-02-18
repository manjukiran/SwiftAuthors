//
//  NSMutableString_Extensions.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    static func highlight(searchTerm: String, text: String, color: UIColor) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: text)
        
        let words = searchTerm.components(separatedBy: " ")
        
        words.forEach {
            let pattern = "(\($0))"
            
            let range: NSRange = NSMakeRange(0, text.count)
            let regex = try! NSRegularExpression( pattern: pattern,
                                                  options: .caseInsensitive)
            regex.enumerateMatches(
                in: text,
                options: NSRegularExpression.MatchingOptions(),
                range: range,
                using: {
                    (textCheckingResult, matchingFlags, stop) -> Void in
                    if let subRange = textCheckingResult?.range {
                        attributedString.addAttribute(NSAttributedString.Key.backgroundColor,
                                                      value: color,
                                                      range: subRange)
                    }
            })
            
        }
        
        return attributedString
    }
}
