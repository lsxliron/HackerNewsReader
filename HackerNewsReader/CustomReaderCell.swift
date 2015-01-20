//
//  CustomReaderCell.swift
//  HackerNewsReader
//
//  Created by Liron Shimrony on 1/19/15.
//  Copyright (c) 2015 Liron Shimrony. All rights reserved.
//

import UIKit

class CustomReaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCustomCell(title: String, score: String, author: String, url: String){
        self.titleLabel.text = title
        self.scoreLabel.text = "Score: \(score)"
        self.urlLabel.text = url
        self.authorLabel.text = "By: \(author)"
    }
    

}
