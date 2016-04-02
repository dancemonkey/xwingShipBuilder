//
//  Squadron.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData

@objc(Squadron)
class Squadron: NSManagedObject {
  
  @NSManaged private var coreName: String
  @NSManaged private var coreShips: [PilotCard]
  @NSManaged private var coreFaction: String
  
  var name: String {
    get {
      return self.coreName
    }
    set {
      self.coreName = newValue
    }
    
  }
  
  var pointCost: Int {
    get {
      var cost = 0
      for ship in coreShips {
        cost += ship.currentPointCost
      }
      return cost
    }
  }
  
  var ships: [PilotCard] {
    return coreShips
  }
  
  var faction: Faction {
    return Faction(rawValue: coreFaction)!
  }
  
  convenience init(name: String, pointCost: Int = 0, faction: Faction, context: NSManagedObjectContext) {
    let entity = NSEntityDescription.entityForName("SquadEntity", inManagedObjectContext: context)
    self.init(entity: entity!, insertIntoManagedObjectContext: context)
    self.coreName = name
    self.coreFaction = faction.rawValue
    self.coreShips = [PilotCard]()
  }
  
  func addPilot(pilot: PilotCard, atIndex index: Int?) {
    if index == nil || coreShips.count == 0 || coreShips.count <= index! {
      coreShips.append(pilot)
    } else {
      coreShips[index!] = pilot
    }
  }
  
  func removePilot(atIndex index: Int) {
    coreShips.removeAtIndex(index)
  }
  
}