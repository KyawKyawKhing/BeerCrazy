//
//  ZoomAbleImageViewController.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class ZoomAbleImageViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var svZoomImage: UIScrollView!
    @IBOutlet weak var ivBeerImage: UIImageView!
    var gradientLayer:CAGradientLayer!
    var imageUrl:String!
    
    override func viewWillAppear(_ animated: Bool) {
        svZoomImage.delegate = self
        svZoomImage.minimumZoomScale = 1.0
        svZoomImage.maximumZoomScale = 5.0
//        gradientLayer = CAGradientLayer()
//
//        gradientLayer.frame = self.view.bounds
//
//        gradientLayer.colors = [UIColor.green.cgColor, UIColor.green.cgColor]
//
//        self.view.layer.addSublayer(gradientLayer)
        
        self.view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        self.view.layer.cornerRadius = 10
        modalPresentationStyle = .custom
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivBeerImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivBeerImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "beer"))
     
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
