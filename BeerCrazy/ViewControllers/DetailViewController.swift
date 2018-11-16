//
//  DetailViewController.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tvDetailView: UITableView!
    
    @IBOutlet weak var ivBeerImage: UIImageView!
    @IBOutlet weak var lblDesp: UILabel!
    var isChecked:Bool = false
    var data:BeerVO!
    let beerIcon = """
    🍺
    beer mug
    Unicode: U+1F37A, UTF-8: F0 9F 8D BA
    """
    let glassIcon = """
    🥂
    clinking glasses
    Unicode: U+1F942, UTF-8: F0 9F A5 82
    """
    let foodIcon = """
    🍽
    fork and knife with plate
    Unicode: U+1F37D, UTF-8: F0 9F 8D BD
    """
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tvDetailView.delegate = self
        tvDetailView.dataSource = self
        
        Utils.cellRegister(nibName: "DetailHeaderTableViewCell", tableView: tvDetailView)
        Utils.cellRegister(nibName: "DetailBodyTableViewCell", tableView: tvDetailView)
        Utils.cellRegister(nibName: "HopsTableViewCell", tableView: tvDetailView)
        
        tvDetailView.rowHeight = UITableView.automaticDimension
        tvDetailView.estimatedRowHeight = 40
        
//        ivBeerImage.sd_setImage(with: URL(string: data.imageURL), placeholderImage: UIImage(named: "beer"))
//        lblDesp.text = data.description
        self.navigationItem.title = data.name
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.lightGray
       
    }
    
    @objc func onClickItemImage(_ sender: UITapGestureRecognizer){
        print("click item image => \(data.imageURL)")
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "ZoomAbleImageViewController") as! ZoomAbleImageViewController
        vc.imageUrl = data.imageURL
        self.present(vc, animated: true, completion: nil)
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
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }

    @IBAction func onClickBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension DetailViewController:UITableViewDelegate{
    
}
extension DetailViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return ""
        }
        if section == 1{
            return "Ingredients (Malt)"
        }else if section == 2{
            return "Ingredients (Hops)"
        }else if section == 3{
            return "Ingredients (Yeast)"
        }
        return "Food Pairing"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return data.ingredients.malt.count
        }else if section == 2{
            return data.ingredients.hops.count
        }else if section == 3{
            return 1
        }else if section == 4{
            return data.foodPairing.count
        }else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0{
           let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderTableViewCell", for: indexPath) as! DetailHeaderTableViewCell
            cell.ivBeerItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItemImage(_ :))))
            cell.setData(data: data)
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailBodyTableViewCell", for: indexPath) as! DetailBodyTableViewCell
            let name = "\(data.ingredients.malt[indexPath.row].name) ( \(data.ingredients.malt[indexPath.row].amount.value) \(data.ingredients.malt[indexPath.row].amount.unit) )"
            cell.lblIcon.text = beerIcon
            cell.lblName.text = name
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HopsTableViewCell", for: indexPath) as! HopsTableViewCell
            let name = "\(data.ingredients.hops[indexPath.row].name) ( \(data.ingredients.hops[indexPath.row].amount.value) \(data.ingredients.hops[indexPath.row].amount.unit ) )"
            cell.lblIcon.text = beerIcon
            cell.lblName.text = name
            let addedAttribute = "add \( data.ingredients.hops[indexPath.row].attribute) at \(data.ingredients.hops[indexPath.row].add)"
            cell.lblAddedAttribute.text = addedAttribute
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailBodyTableViewCell", for: indexPath) as! DetailBodyTableViewCell
            cell.lblIcon.text = beerIcon
            cell.lblName.text = data.ingredients.yeast
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailBodyTableViewCell", for: indexPath) as! DetailBodyTableViewCell
            cell.lblIcon.text = foodIcon
            cell.lblName.text = data.foodPairing[indexPath.row]
            return cell
        }
    }
}
