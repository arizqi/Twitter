//
//  MenuItemCell.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/28/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var menuItemLabel: UILabel!
    
    @IBOutlet weak var menuItemImage: UIImageView!
    
    func configureForMenuItem(menuItem: MenuItem) {
        menuItemLabel.text = menuItem.title
        menuItemImage.image = menuItem.image
    }


}
