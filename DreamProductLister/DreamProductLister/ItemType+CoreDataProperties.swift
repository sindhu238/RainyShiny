//
//  ItemType+CoreDataProperties.swift
//  DreamProductLister
//
//  Created by Venkateswara on 24/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toIem: Item?

}
