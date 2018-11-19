//
//  HomeViewController.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var beerListCollectionView: UICollectionView!
    var beerItemList:[BeerVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.cellRegister(nibName: "BeerItemCollectionViewCell", collectionView: beerListCollectionView)
        beerListCollectionView.dataSource  = self
        beerListCollectionView.delegate = self
        
        print("Get Data From Network\(beerItemList.count)")
    }
    override func viewWillAppear(_ animated: Bool) {
//        getBeerList()
        CustomLoadingView.shared().showActivityIndicator(uiView: self.view)
        BeerModel.shared().getAllBeer(context: managedObjectContext, success: { (beerList) in
            self.beerItemList = beerList
            self.beerListCollectionView.reloadData()
            CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }) { (error) in
            
        CustomLoadingView.shared().hideActivityIndicator(uiView: self.view)
            
        }
    }
    func getBeerList() {
        do {
            beerItemList = try self.managedObjectContext.fetch(Beer.fetchRequest()) as! [BeerVO]
            self.beerListCollectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/2-20
        return CGSize(width: width, height: width*1.8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
        let vc = navigationVC.viewControllers[0] as! DetailViewController
        vc.data = beerItemList[indexPath.row]
        self.present(navigationVC, animated: true, completion: nil)
    }
}

extension HomeViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerItemList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerItemCollectionViewCell", for: indexPath) as! BeerItemCollectionViewCell
        cell.setData(data: beerItemList[indexPath.row])
        return cell
    }
}

extension HomeViewController:LoadDataCallback{
    func onLoadDataSucceed(dataList: [BeerVO]) {
        beerItemList = dataList
        self.beerListCollectionView.reloadData()
        print("Load Data Succeed => \(dataList.count)")
    }
    
    func onLoadDataFailed(errormessage: String) {
        print("Load Data Failed => \(errormessage)")
    }
}
