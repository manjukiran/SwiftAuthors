//
//  UIView_Extensions.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

extension UIView {
    
    /// UIView utility to ensure provided block runs on Main Thread
    ///
    /// Also helps avoid EXC_BAD_INSTRUCTION errors
    ///
    /// - Parameter block: closure containing the code to run
    class func runOnMainThread(block: () -> ()) {
        if Thread.isMainThread {
            block()
            return
        }
        DispatchQueue.main.sync {
            block()
        }
    }
    
    func applyRadius(_ radius: CGFloat) {
        self.layer.cornerRadius =  radius
        self.clipsToBounds = true
    }
    
    func applyStroke(strokeWidth: CGFloat, strokeColor: UIColor, cornerRadius: CGFloat = 0.0) {
        self.layer.borderWidth = strokeWidth
        self.layer.borderColor = strokeColor.cgColor
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
        self.layer.masksToBounds = true
    }
    
}
