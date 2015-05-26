//
//  RepoCell.swift
//  Repos
//
//  Created by Josh Brown on 5/15/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var descriptionBottomConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.width
        descriptionLabel.preferredMaxLayoutWidth = descriptionLabel.bounds.width
        starsLabel.preferredMaxLayoutWidth = starsLabel.bounds.width
    }
}