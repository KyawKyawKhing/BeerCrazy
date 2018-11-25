//
//  DetailHeaderTableViewCell.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/12/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBeerName: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var ivBeerItem: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblBrewerTip: UILabel!
    @IBOutlet weak var lblFirstBrewed: UILabel!
    @IBOutlet weak var lblContributedBy: UILabel!
    
    var data:BeerVO!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivBeerItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItemImage(_ :))))
    }
    @objc func onClickItemImage(_ sender: UITapGestureRecognizer){
        print("click item image => \(data.imageURL)")
        let vc = self.window?.rootViewController!.storyboard!.instantiateViewController(withIdentifier: "ZoomAbleImageViewController") as! ZoomAbleImageViewController
        vc.imageUrl = data.imageURL
        self.window?.rootViewController!.present(vc, animated: true, completion: nil)
        //        let imageView = sender.view as! UIImageView
        //        let newImageView = UIImageView(image: imageView.image)
        //        newImageView.frame = UIScreen.main.bounds
        //        newImageView.backgroundColor = .white
        //        newImageView.contentMode = .scaleAspectFit
        //        newImageView.isUserInteractionEnabled = true
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        //        newImageView.addGestureRecognizer(tap)
        //        self.view.addSubview(newImageView)
        //        self.navigationController?.isNavigationBarHidden = true
        //        self.tabBarController?.tabBar.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:BeerVO){
        self.data = data
        lblBeerName.text = data.name
        lblTagline.text = data.tagline
        ivBeerItem.sd_setImage(with: URL(string: data.imageURL), placeholderImage: UIImage(named: "beer"))
        lblDescription.text = data.description
        lblBrewerTip.text = data.brewersTips
        lblFirstBrewed.text = data.firstBrewed
        lblContributedBy.text = data.contributedBy!.rawValue
    }
    
}
