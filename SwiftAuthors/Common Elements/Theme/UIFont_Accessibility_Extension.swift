//
//  UIFont_Accessibility_Extension.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import Foundation
import UIKit

/* We can provide a custom font here
 
 let CLBoldFontName = "<Some-Bold-Font-Name>"
 let CLRegularFontName = "<Some-Bold-Font-Name>"
 
 */


extension UIFont {
    
    /// Retrieves font for the corresponding text style
    /// - Parameter style: style for the text to be displayed
    static func fontForStyle(style: UIFont.TextStyle) -> UIFont {
        if #available(iOS 11.0, *) {
            switch style {
            case .largeTitle:
                return UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
            case .title1:
                return UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.semibold)
            case .title2, .headline:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.semibold)
            case .title3:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.light)
            case .subheadline:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.light)
            case .body:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.thin)
            case .callout:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.thin)
            case .footnote:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
            case .caption1:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.light)
            case .caption2:
               return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.light)
            default:
                return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
            }
        } else {
            // Handle Pre-iOS 11 scenario
            return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
        }
    }
    
    /// Used to customise the font color for its own style
    /// Can be used to keep all the fonts of a type in the same color so that the UX is consistent
    /// - Parameter style: style for the text to be displayed
    static func fontColorForStyle(style: UIFont.TextStyle) -> UIColor {
        if #available(iOS 11.0, *) {
            switch style {
            case .largeTitle:
                return UIColor.black
            case .title1:
                return UIColor.black
            case .title2:
                return UIColor.black
            case .title3:
                return AppTheme.actionItemColor ?? UIColor.black
            case .headline:
                return UIColor.black
            case .subheadline:
                return UIColor.darkGray
            case .body:
                return UIColor.black
            case .callout:
                return UIColor.darkGray
            case .footnote:
                return UIColor.darkGray
            case .caption1:
                return UIColor.black
            case .caption2:
                return UIColor.black
            default:
                return UIColor.black
            }
        } else {
            // Handle Pre-iOS 11 scenario
            return UIColor.black
        }
    }
    
}

