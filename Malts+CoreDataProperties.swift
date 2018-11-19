//
//  Malts+CoreDataProperties.swift
//  
//
//  Created by AcePlus101 on 11/19/18.
//
//

import Foundation
import CoreData


extension Malts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Malts> {
        return NSFetchRequest<Malts>(entityName: "Malts")
    }

    @NSManaged public var amount_unit: String?
    @NSManaged public var amount_value: String?
    @NSManaged public var ingredient_id: String?
    @NSManaged public var name: String?

}
