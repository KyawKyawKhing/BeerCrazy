//
//  BeerItemCollectionViewCell.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class BeerItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivBeerImage: UIImageView!
    @IBOutlet weak var lblBeerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data:BeerVO){
        ivBeerImage.sd_setImage(with: URL(string: data.imageURL), placeholderImage: UIImage(named: "beer"))
        lblBeerName.text = data.name
    }

}
