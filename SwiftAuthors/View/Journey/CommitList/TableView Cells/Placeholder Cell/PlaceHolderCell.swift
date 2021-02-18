//
//  PlaceHolderCell.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

class PlaceHolderCell: UITableViewCell {
    
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var placeholderTextView: UITextView!
    
    override func awakeFromNib() {
        self.placeholderTextView.configureFor(style: .subheadline)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.placeholderTextView.configureFor(style: .subheadline)
        self.placeholderImage.image = nil
        self.placeholderTextView.text = ""
    }
    
    func configureCell(imageName: String, text: String) {
        self.placeholderImage.image = UIImage(named: imageName)
        self.placeholderTextView.text = text
    }
}
