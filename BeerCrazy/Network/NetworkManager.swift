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
//                            self.saveDataIntoDB(beerList: beerList)
                            success(beerList)
//                            callback.onLoadDataSucceed(dataList:beerList)
                            print("Beer Item List Count => \(beerList.count)")
                        } catch let jsonErr {
                            print("JSONSerialization error ==> \(jsonErr.localizedDescription)")
//                            callback.onLoadDataFailed(errormessage: jsonErr.localizedDescription)
                            failure(jsonErr)
                        }
                    })
                }
            case .failure(let error):
                print("Load Data Failed => \(error.localizedDescription)")
//                callback.onLoadDataFailed(errormessage: error.localizedDescription)
                failure(error)
            }
        }
    }
    
    func saveDataIntoDB(beerList:[BeerVO]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let beerEntity = NSEntityDescription.entity(forEntityName: "Beer", in: managedObjectContext)
        let beer = NSManagedObject(entity: beerEntity!, insertInto: managedObjectContext)
       
        let foodPairingEntity = NSEntityDescription.entity(forEntityName: "Food_Pairing", in: managedObjectContext)
        let foodPairing = NSManagedObject(entity: foodPairingEntity!, insertInto: managedObjectContext)
       
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: managedObjectContext)
        let ingredient = NSManagedObject(entity: ingredientEntity!, insertInto: managedObjectContext)
      
        let maltEntity = NSEntityDescription.entity(forEntityName: "Malts", in: managedObjectContext)
        let malt = NSManagedObject(entity: maltEntity!, insertInto: managedObjectContext)
        
        let hopEntity = NSEntityDescription.entity(forEntityName: "Hops", in: managedObjectContext)
        let hop = NSManagedObject(entity: hopEntity!, insertInto: managedObjectContext)
       
        beer.setValue("added name", forKey: "name")
        var i = 0
        while i<beerList.count {
            
            let beerVO = beerList[i]
            
//            ingredient.setValue("\(i) ", forKey: "beer_id")
//            ingredient.setValue(beerVO.ingredients.yeast, forKey: "yeast")
//            ingredient.setValue(i, forKey: "beer_id")
//
//            var ii = 0
//            while ii<beerVO.ingredients.malt.count{
//            malt.setValue("\(i)\(ii)", forKey: "id")
//            malt.setValue(beerVO.ingredients.malt[ii].name, forKey: "name")
//            malt.setValue(beerVO.ingredients.malt[ii].amount.value, forKey: "amount_value")
//            malt.setValue(beerVO.ingredients.malt[ii].amount.unit, forKey: "amount_unit")
//            malt.setValue(i, forKey: "ingredient_id")
//            ii+=1
//            }
//
//            var iii = 0
//            while ii<beerVO.ingredients.hops.count{
//                hop.setValue(beerVO.ingredients.hops[iii].name, forKey: "name")
//                hop.setValue(beerVO.ingredients.hops[iii].amount.value, forKey: "amount_value")
//                hop.setValue(beerVO.ingredients.hops[iii].amount.unit, forKey: "amount_unit")
//                hop.setValue(beerVO.ingredients.hops[iii].add.rawValue, forKey: "add")
//                hop.setValue(beerVO.ingredients.hops[iii].attribute.rawValue, forKey: "attribute")
//                malt.setValue(i, forKey: "ingredient_id")
//                iii+=1
//            }
//
//            var iiii = 0
//            while iiii<beerVO.foodPairing.count{
//                foodPairing.setValue(i, forKey: "beer_id")
//           foodPairing.setValue(beerVO.foodPairing[iiii], forKey: "food_name")
//                iiii+=1
//            }
            
            beer.setValue("\(i)", forKey: "beer_id")
            beer.setValue(beerVO.name, forKey: "name")
            beer.setValue(beerVO.description, forKey: "desp")
            beer.setValue(beerVO.brewersTips, forKey: "brewers_tips")
            beer.setValue(beerVO.firstBrewed, forKey: "first_brewed")
            beer.setValue(beerVO.tagline, forKey: "tagline")
            beer.setValue(beerVO.imageURL, forKey: "image_url")
            beer.setValue(beerVO.contributedBy, forKey: "contributed_by")
            beer.setValue("\(i)", forKey: "ingredient_id")
            
            i+=1
        }
        
        do {
            try managedObjectContext.save()
            print("Successfully Saving")
            
//           do {
//                 let beerList = try managedObjectContext.fetch(Beer.fetchRequest()) as! [BeerVO]
//                print("saved count => \(beerList.count)")
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
        } catch {
            print("Failed saving")
        }
    }
    
    func getDataFromDB() -> [BeerVO] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        //We need to create a context from this container
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        var beerList:[BeerVO] = []
        let ingredientFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Ingredient")
        let maltFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Malts")
        let hopFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Hops")
        let foodPairingFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Food_Pairing")
        
        do {
            beerList = try managedObjectContext.fetch(Beer.fetchRequest()) as! [BeerVO]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        var i = 0
        while i<beerList.count {
            var beerVO = beerList[i]
            
//            ingredientFetchRequest.predicate = NSPredicate(format: "ingredient_id = %@", i)
            ingredientFetchRequest.predicate = NSPredicate(format: "beer_id = %@", i)
            do{
            let ingredientList = try managedObjectContext.fetch(ingredientFetchRequest)
             let ingredient = ingredientList[0]
                beerVO.ingredients = ingredient as! Ingredients
        } catch let error {
            print(error.localizedDescription)
        }
            
            
            maltFetchRequest.predicate = NSPredicate(format: "ingredient_id = %@", i)
                
            
            
            hopFetchRequest.predicate = NSPredicate(format: "ingredient_id = %@", i)
            
            
            foodPairingFetchRequest.predicate = NSPredicate(format: "beer_id = %@", i)
            
            i+=1
        }
        return beerList
    }
    
}

protocol LoadDataCallback {
    func onLoadDataSucceed(dataList:[BeerVO])
    func onLoadDataFailed(errormessage:String)
}
