//
//  CommitCell.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

class CommitCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var commitDateLabel : UILabel!
    @IBOutlet weak var commitMessageLabel : UILabel!
    @IBOutlet weak var authorImageView : UIImageView!
    
    let highLightColor: UIColor = (AppTheme.actionItemColor ?? UIColor.yellow).withAlphaComponent(0.3)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.configureFor(style: .title1)
        self.commitDateLabel.configureFor(style: .subheadline)
        self.commitMessageLabel.configureFor(style: .subheadline)
        if let themeColor = AppTheme.themeColor {
            self.authorImageView.applyStroke(strokeWidth: 3.0, strokeColor: themeColor, cornerRadius: 3.0)
        }
    }
    
    override func prepareForReuse() {
        self.nameLabel.text = ""
        self.commitDateLabel.text = ""
        self.authorImageView.image = UIImage(named: "Swift-placeholder")
    }
    
    func configureWithCommit(commit: CommitElement, searchText: String? = nil) {
        if let searchText = searchText {
            self.nameLabel.attributedText = NSMutableAttributedString.highlight(searchTerm: searchText,
                                                                                 text: commit.commit.author.name,
                                                                                 color: highLightColor)
            
            self.commitMessageLabel.attributedText = NSMutableAttributedString.highlight(searchTerm: searchText,
                                                                                         text: commit.commit.message,
                                                                                         color: highLightColor)
        } else {
            self.nameLabel.text = commit.commit.author.name
            self.commitMessageLabel.text = commit.commit.message
        }
        self.commitDateLabel.text = "committed_on_prefix".localized() + " " + commit.commit.author.date.toString(format: .displayDate)
    }
    
    func configureImage(image: UIImage) {
        self.authorImageView.image = image
    }
}
