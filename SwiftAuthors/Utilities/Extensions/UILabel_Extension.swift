//
//  UILabel_Extension.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

extension UILabel {
    
    func configureFor(style: UIFont.TextStyle) {
        self.font = AppTheme.shared.fontFor(style: style)
        self.textColor = AppTheme.shared.fontColorFor(style: style)
    }
    
}
