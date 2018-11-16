//
//  ZoomAbleImageViewController.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class ZoomAbleImageViewController: UIViewController {
    
    @IBOutlet weak var ivBeerImage: UIImageView!
    var gradientLayer:CAGradientLayer!
    var imageUrl:String!
    
    override func viewWillAppear(_ animated: Bool) {
        
//        gradientLayer = CAGradientLayer()
//
//        gradientLayer.frame = self.view.bounds
//
//        gradientLayer.colors = [UIColor.green.cgColor, UIColor.green.cgColor]
//
//        self.view.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivBeerImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "beer"))
     
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
