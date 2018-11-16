//
//  HopsTableViewCell.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/16/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class HopsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblIcon: UILabel!
    @IBOutlet weak var lblName: UILabel!
   
    @IBOutlet weak var lblAddedAttribute: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
