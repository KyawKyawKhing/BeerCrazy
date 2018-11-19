//
//  BeerModel.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import CoreData

class BeerModel {
    
    private init() {}
    
    private static var sharedDataModel: BeerModel = {
        let beerModel = BeerModel()
        return beerModel
    }()
    
    class func shared() -> BeerModel {
        return sharedDataModel
    }
    
    //like singleton
    
    func getAllBeer(context : NSManagedObjectContext,
                             success: @escaping ([BeerVO]) -> Void,
                             failure: @escaping (Error) -> Void) {
        
        let networkManager = NetworkManager()
        networkManager.getAllBeer(success: { (beerList) in
            DispatchQueue.main.async {
                success(beerList)
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }
        
    }
    
}
