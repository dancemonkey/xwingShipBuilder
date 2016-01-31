//
//  PilotCard.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

// ship can initialize, display available upgrades, and attach upgrades.
// ship can NOT remove upgrades/reset upgrades to stock
// ship can NOT return available actions/track action already used during turn
//    - should ship track this or the game state?

import Foundation

enum Faction: String {
  case Rebel, Imperial, Scum
}

enum Actions: String {
  case Focus, TargetLock, Evade, BarrelRoll, Cloak
}

class PilotCard {
  
  private let _shipCard: ShipData.Ship!
  private var _originalUpgrades = [String]()
  var originalUpgrades: [String] {
    get {
      return _originalUpgrades
    }
  }
  private var _availUpgrades = [String]()
  var availUpgrades: [String] {
    get {
        return _availUpgrades
      }
  }
  private var _currentUpgrades = [String]()
  var currentUpgrades: [String] {
    get {
        return _currentUpgrades
      }
  }
  
  init(ship: String, pilot: String) {
    let ships = ShipData()
    _shipCard = ships.getShip(ofType: ship, withPilot: pilot)
    _availUpgrades = _shipCard.avail_Upgrades
    _originalUpgrades = _availUpgrades
  }
  
  func attachUpgrade(upgrade: String) -> Bool {
    if _availUpgrades.contains(upgrade) {
      _currentUpgrades.append(upgrade)
      for (index, entry) in _availUpgrades.enumerate() {
        if entry == upgrade {
          _availUpgrades.removeAtIndex(index)
        }
      }
      return true
    } else {
      return false
    }
  }
  
}