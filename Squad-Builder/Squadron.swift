//
//  Squadron.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

// ???: do i need to convert this to the managed object i was working with in the testCoreDataVC file, and then have all of the various screens read this instead?

import Foundation
import CoreData

class Squadron {
  
  private var _name: String
  private var _pointCost: Int
  private var _ships = [PilotCard]()
  private var _faction: Faction
  
  var name: String {
    get {
      return self._name
    }
    set {
      self._name = newValue
    }
    
  }
  
  var pointCost: Int {
    get {
      var cost = 0
      for ship in _ships {
        cost += ship.currentPointCost
      }
      return cost
    }
  }
  
  var ships: [PilotCard] {
    return _ships
  }
  
  var faction: Faction {
    return _faction
  }
  
  init(name: String, pointCost: Int = 0, faction: Faction) {
    self._name = name
    self._pointCost = pointCost
    self._faction = faction
  }
  
  func addPilot(pilot: PilotCard, atIndex index: Int?) {
    if index == nil || _ships.count == 0 || _ships.count <= index! {
      _ships.append(pilot)
    } else {
      _ships[index!] = pilot
    }
  }
  
  func removePilot(atIndex index: Int) {
    _ships.removeAtIndex(index)
  }
  
}