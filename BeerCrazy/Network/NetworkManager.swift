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
import CoreData

class NetworkManager{
    
    func getAllBeer(success: @escaping ([BeerVO]) -> Void,
                    failure: @escaping (Error) -> Void){
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
                            print("Beer Item List Count => \(beerList.count)")
                        } catch let jsonErr {
                            print("JSONSerialization error ==> \(jsonErr.localizedDescription)")
                            failure(jsonErr)
                        }
                    })
                    success(beerList)
                }
            case .failure(let error):
                print("Load Data Failed => \(error.localizedDescription)")
                failure(error)
            }
        }
    }
    
}
