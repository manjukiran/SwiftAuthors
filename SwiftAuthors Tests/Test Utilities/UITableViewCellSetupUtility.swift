//
//  UITableViewCellSetupUtility.swift
//  SwiftAuthors Tests
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import XCTest
import UIKit

@testable import SwiftAuthors

class UITableViewCellSetupUtility<T: UITableViewCell> : NSObject {
       
    class func setupTopLevelUI(withCell cell: T.Type) -> T? {
        let nibFile = Bundle.main.loadNibNamed(T.reuseIdentifier, owner: self, options: nil)
        if let cell = nibFile?.first as? T {
            return cell
        }
        return nil
    }
    
}
