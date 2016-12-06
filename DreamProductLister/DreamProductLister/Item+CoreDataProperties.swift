//
//  Item+CoreDataProperties.swift
//  DreamProductLister
//
//  Created by Venkateswara on 24/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var details: String?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?
    @NSManaged public var toImage: Image?

}
