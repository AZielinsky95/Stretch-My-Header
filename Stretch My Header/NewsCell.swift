//
//  NewsCell.swift
//  Stretch My Header
//
//  Created by Alejandro Zielinsky on 2018-05-22.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var HeadlineLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
