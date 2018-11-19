//
//  Extensions.swift
//  BeerCrazy
//
//  Created by AcePlus101 on 11/17/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
//    var managedObjectContext: NSManagedObjectContext! {
//        get{
//            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        }
//    }
    
    var managedObjectContext: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
}

