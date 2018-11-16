//
//  BeerCrazyModel.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/11/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

class BeerCrazyModel{
    
    func getAllBeer(callback:LoadDataCallback){
        let url = URL(string: "https://api.punkapi.com/v2/beers")
        Alamofire.request(url!).responseJSON{response in
            switch response.result{
            case .success(let response):
                let dataList = JSON(response).array
                if let result = dataList {
                    var beerList : [BeerVO] = []
                    result.forEach({ (beer) in
                       let data = try! beer.rawData()
                        do {
                            let beerVO = try JSONDecoder().decode(BeerVO.self, from: data)
                            beerList.append(beerVO)
                            callback.onLoadDataSucceed(dataList: beerList)
                            print("Beer Item List Count => \(beerList.count)")
                        } catch let jsonErr {
                            print("JSONSerialization error ==> \(jsonErr.localizedDescription)")
                            callback.onLoadDataFailed(errormessage: jsonErr.localizedDescription)
                        }
                    })
                }
            case .failure(let error):
                print("Load Data Failed => \(error.localizedDescription)")
                callback.onLoadDataFailed(errormessage: error.localizedDescription)
            }
        }
    }
    
}

protocol LoadDataCallback {
    func onLoadDataSucceed(dataList:[BeerVO])
    func onLoadDataFailed(errormessage:String)
}
