//
//  PilotCard.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: refactor upgrades on ship to handle upgrade types and their effects when attaching to ship

import Foundation

enum Faction: String {
  case Rebel, Imperial, Scum
}

enum Actions: String {
  case Focus, TargetLock, Evade, BarrelRoll, Cloak, Boost, Decloak, SLAM
}

enum UpgradeType: String {
  case Elite, Astromech, Torpedoes, Missiles, Cannon, Turret, Bomb, Crew, SalvagedAstromech, System, Title, Modification, Illicit, Cargo, Hardpoint, Team, Tech
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
        return _availUpgrades.sort()
      }
  }
  private var _currentUpgrades = [String]()
  var currentUpgrades: [String] {
    get {
        return _currentUpgrades.sort()
      }
  }
  var cardText: String {
    get {
      return _shipCard.text
    }
  }
  struct Stats {
    var attack: Int
    var evade: Int
    var hull: Int
    var shield: Int
  }
  private var _shipStats: Stats!
  var shipStats: Stats {
    get {
      return _shipStats
    }
  }
  var shipPointCost: Int {
    get {
      return _shipCard.pointCost
    }
  }
  
  init(ship: String, pilot: String) {
    let ships = ShipData()
    _shipCard = ships.getShip(ofType: ship, withPilot: pilot)
    _availUpgrades = _shipCard.avail_Upgrades
    _availUpgrades.append("Title")
    _availUpgrades.append("Modification")
    _originalUpgrades = _availUpgrades
    _shipStats = Stats(attack: _shipCard.stat_Attack, evade: _shipCard.stat_Evade, hull: _shipCard.stat_Hull, shield: _shipCard.stat_Shield)
  }
  
  // REFACTOR THIS TO TEST FOR THE AVAILABILITY OF THE UPGRADE /TYPE/, THEN PUT THE UPGRADE /NAME/ IN THE CURRENT UPGRADES ARRAY
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
  
  func removeUpgrade(upgrade: String) -> Bool {
    if _currentUpgrades.contains(upgrade) {
      _currentUpgrades.removeAtIndex(_currentUpgrades.indexOf(upgrade)!)
      _availUpgrades.append(upgrade)
      return true
    } else {
      return false
    }
  }
  
  func clearUpgrades() {
    _availUpgrades = _originalUpgrades
    _currentUpgrades.removeAll()
  }
  
}