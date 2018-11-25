//
//  BeerModel.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import CoreData
import UIKit

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
        let beerList = self.getBeerList(managedObjectContext: context)
        if beerList.count>0 {
            success(beerList)
        }else{
        networkManager.getAllBeer(success: { (beerList) in
            DispatchQueue.main.async {
                 self.saveData(managedObjectContext: context,beerList: beerList)
                success(self.getBeerList(managedObjectContext: context))
            }
        }) { (error) in
            DispatchQueue.main.async {
                failure(error)
            }
        }
        }
        
    }
    func saveData(managedObjectContext : NSManagedObjectContext,beerList:[BeerVO]){
        self.deleteAllData("Beer", managedObjectContext: managedObjectContext)
        var i = 0
        while i<beerList.count {
            let beerVO = beerList[i]
            let beer = Beer(context: managedObjectContext)
            beer.beer_id = "\(beerVO.id)"
            beer.name = beerVO.name
            beer.image_url = beerVO.imageURL
            beer.tagline = beerVO.tagline
            beer.first_brewed = beerVO.firstBrewed
            beer.contributed_by = beerVO.contributedBy!.rawValue
            beer.brewers_tips = beerVO.brewersTips
            beer.desp = beerVO.description
            
            let ingredient = Ingredient(context: managedObjectContext)
            ingredient.yeast = beerVO.ingredients!.yeast
            
            var ii = 0
            while ii<beerVO.ingredients!.malt.count{
                let malt = Malts(context: managedObjectContext)
                malt.name = beerVO.ingredients!.malt[ii].name
                malt.amount_value = "\(beerVO.ingredients!.malt[ii].amount.value)"
                malt.amount_unit = "\(beerVO.ingredients!.malt[ii].amount.unit)"
                ingredient.addToMalts(malt)
                ii += 1
            }
            
            var iii = 0
            while iii<beerVO.ingredients!.hops.count{
                let hop = Hops(context: managedObjectContext)
                hop.name = beerVO.ingredients!.hops[iii].name
                hop.amount_value = "\(beerVO.ingredients!.hops[iii].amount.value)"
                hop.amount_unit = "\(beerVO.ingredients!.hops[iii].amount.unit)"
                hop.attribute = "\(beerVO.ingredients!.hops[iii].attribute)"
                hop.add = "\(beerVO.ingredients!.hops[iii].add)"
                ingredient.addToHops(hop)
                iii += 1
            }
            
            beer.ingredient = ingredient
            
            var iiii = 0
            while iiii<beerVO.foodPairing.count{
                let foodPairing = Food_Pairing(context: managedObjectContext)
                foodPairing.food_name = beerVO.foodPairing[iiii]
                beer.addToFood_pairing(foodPairing)
                iiii+=1
            }
            
            i += 1
        }
        do {
            try managedObjectContext.save()
            print("Successfully Saving")
            
        } catch {
            print("Failed saving")
        }
        
        do {
            let beerList = try managedObjectContext.fetch(Beer.fetchRequest())
            print("saved count => \(beerList.count)")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getBeerList(managedObjectContext:NSManagedObjectContext) -> [BeerVO] {
        
        var dataArray:[BeerVO] = []
        do {
            let result = try managedObjectContext.fetch(Beer.fetchRequest())
            for data in result as! [NSManagedObject] {
                let beer = data as! Beer
                print("Result Beer => \(beer.name ?? "nil name")")
                print("Result Beer => \(String(describing: beer.ingredient))")
                if (data.value(forKey: "name") != nil){
                    print(data.value(forKey: "name") as! String)
                    
                    var beerVO = BeerVO.init(id: 0, name: "", tagline: "", firstBrewed: "", description: "", imageURL: "", abv: 0.0, ibu: 0.0, targetFg: 0, targetOg: 0.0, ebc: 0, srm: 0.0, ph: 0.0, attenuationLevel: 0.0, volume: nil, boilVolume: nil, method: nil, ingredients: nil, foodPairing: [], brewersTips: "", contributedBy: nil)
                    
                    beerVO.id = 0
                    beerVO.brewersTips = beer.brewers_tips!
                    beerVO.contributedBy = beer.contributed_by.map { ContributedBy(rawValue: $0) }!
                    beerVO.description = beer.desp!
                    beerVO.firstBrewed = beer.first_brewed!
                    beerVO.imageURL = beer.image_url ?? "beer"
                    beerVO.name = beer.name!
                    beerVO.tagline = beer.tagline!
                    var ingredient = Ingredients.init(malt: [], hops: [], yeast: "unknown")
                    ingredient.yeast = (beer.ingredient?.yeast)!
                    
                    if let hops = beer.ingredient?.hops?.allObjects as? [Hops] {
                        
                        print("\(hops.count) => \(hops[0].amount_value ?? "nil value"))")
                    } else {
                        print("hops nil")
                    }
                    
                    var hops:[Hop] = []
                    var j = 0
                    while  j < beer.ingredient?.hops?.count ?? 0{
                        let hop = beer.ingredient?.hops?.allObjects[j] as? Hops
                        
                        let unit = Unit.init(rawValue: hop?.amount_unit ?? "")
                        let boilVolume = BoilVolume.init(value: (NumberFormatter().number(from: (hop?.amount_value)!)?.doubleValue)!, unit: (unit ?? nil)!)
                        let add = Add.init(rawValue: hop?.add ?? "start")
                        let attribute = Attribute.init(rawValue: hop?.attribute ?? "aroma")
                        let hopVo = Hop.init(name: hop?.name ?? "", amount: boilVolume, add: add ?? Add.init(rawValue: "start")!, attribute: attribute ?? Attribute.init(rawValue: "aroma")!)
                        
                       hops.append(hopVo)
                        j += 1
                    }
                    ingredient.hops = hops
                    
                    var malts:[Malt] = []
                    var jj = 0
                    while  jj<beer.ingredient?.malts?.count ?? 0{
                        let malt = beer.ingredient?.malts?.allObjects[jj] as? Malts
                        
                        let unit = Unit.init(rawValue: malt?.amount_unit ?? "celsius")
                        let boilVolume = BoilVolume.init(value: (NumberFormatter().number(from: (malt?.amount_value)!)?.doubleValue)!, unit: (unit ?? Unit(rawValue: "celsius"))!)
                        let maltVO = Malt.init(name: malt?.name ?? "", amount: boilVolume)
                        
                        malts.append(maltVO)
                        jj += 1
                    }
                    ingredient.malt = malts
                    beerVO.ingredients = ingredient
                    
                    var foodPairing:[String] = []
                    let foodPairings = beer.food_pairing?.allObjects as? [Food_Pairing]
                    foodPairings?.forEach{ (foods) in
                        foodPairing.append(foods.food_name ?? "")
                    }
                    beerVO.foodPairing = foodPairing
                    
                    dataArray.append(beerVO)
                    
                }
            }
            
        } catch let error as NSError  {
            print("Get BeerList Error=> \(error.userInfo)")
        }
        return dataArray
        
    }
    func deleteAllData(_ entity:String,managedObjectContext:NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedObjectContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
