//
//  DetailBodyTableViewCell.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/14/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class DetailBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var lblIcon: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
