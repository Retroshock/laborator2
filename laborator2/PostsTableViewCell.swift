//
//  PostsTableViewCell.swift
//  laborator2
//
//  Created by Adrian Popovici on 12/03/2019.
//  Copyright © 2019 laborator. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet private weak var postTitleLabel: UILabel!

    private(set) var model: PostModel! {
        didSet {
            postTitleLabel.text = model.title
        }
    }

    func configure(withModel model: PostModel) {
        self.model = model
    }
}
