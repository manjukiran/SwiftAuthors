//
//  UITableView_Extensions.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//


import UIKit

// MARK: - This set of extension is all about registering TableView cells

extension UITableView {
    
    func register<T : UITableViewCell>(cell: T.Type, nibName:String) {
        register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func reloadOnMainThread() {
        UIView.runOnMainThread { [weak self] in
            self?.reloadData()
        }
    }
}
