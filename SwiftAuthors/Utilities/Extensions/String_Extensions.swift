//
//  String_Extensions.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation

extension String {
    
    /// Utility to help access the localized string without having to type the lengthy NSLocalizedString(..:..) macro
    ///
    /// Using this will not help developer while using the usual GENSTRINGS command on TERMINAL
    /// It is imperative to ensure all strings are added to the Localizable.strings file
    ///
    /// - Returns: localised string (if defined in the Localizable.strings file
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Converts String to a Date object (useful in current scenario where dates are returned as strings)
    ///
    /// - Parameter format: Date format
    /// - Returns: optional Date object
    func toDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
