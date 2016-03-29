//
//  Squad.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/25/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData

@objc(Squad)
class Squad: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

  @NSManaged var name: String?
  @NSManaged var pointCost: NSNumber?
  @NSManaged var ships: [AnyObject]
  @NSManaged var faction: String?

}
