//
//  Squadron.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation

class Squadron {
  
  private var _name: String
  private var _pointCost: Int
  private var _ships = [PilotCard]()
  private var _faction: Faction
  
  var name: String {
    return self._name
  }
  
  var pointCost: Int {
    return _pointCost
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
  
  func addPilot(pilot: PilotCard) {
    self._ships.append(pilot)
  }
  
}