//
//  Food_Pairing+CoreDataProperties.swift
//  
//
//  Created by AcePlus101 on 11/19/18.
//
//

import Foundation
import CoreData


extension Food_Pairing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food_Pairing> {
        return NSFetchRequest<Food_Pairing>(entityName: "Food_Pairing")
    }

    @NSManaged public var beer_id: Int32
    @NSManaged public var food_name: String?

}
