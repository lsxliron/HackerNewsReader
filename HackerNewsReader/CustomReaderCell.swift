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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCustomCell(title: String){
        self.titleLabel.text = title
    }
    

}
