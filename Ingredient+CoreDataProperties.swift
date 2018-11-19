//
//  Ingredient+CoreDataProperties.swift
//  
//
//  Created by AcePlus101 on 11/19/18.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var beer_id: Int32
    @NSManaged public var ingredient_id: String?
    @NSManaged public var yeast: String?

}
