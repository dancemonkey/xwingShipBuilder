//
//  PilotCard.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation

enum Faction: String {
  case Rebel, Imperial, Scum
}

enum Actions: String {
  case Focus, TargetLock, Evade, BarrelRoll, Cloak, Boost, Decloak, SLAM
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
  private var _actions = [Actions]()
  var actions: [Actions] {
    get {
      return _actions
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
  
  var startingPointCost: Int {
    get {
      return _shipCard.pointCost
    }
  }
  var currentPointCost: Int
  
  var shipType: String {
    get {
      return _shipCard.shipType
    }
  }
  
  var pilotName: String? {
    get {
      return _shipCard.pilotName
    }
  }
  
  var faction: String {
    get {
      return _shipCard.faction.rawValue
    }
  }
  
  init(ship: String, pilot: String?) {
    let ships = ShipData()
    _shipCard = ships.getShip(ofType: ship, withPilot: pilot)
    _availUpgrades = _shipCard.avail_Upgrades
    _availUpgrades.append("Title")
    _availUpgrades.append("Modification")
    _originalUpgrades = _availUpgrades
    self._actions = _shipCard.avail_Actions
    _shipStats = Stats(attack: _shipCard.stat_Attack, evade: _shipCard.stat_Evade, hull: _shipCard.stat_Hull, shield: _shipCard.stat_Shield)
    currentPointCost = _shipCard.pointCost
  }
  
  func attachUpgrade(upgrade: UpgradeCard) -> Bool {
    if _availUpgrades.contains(upgrade.type.rawValue) {
      _currentUpgrades.append(upgrade.name)
      //TODO: also must add upgrade points cost to current point cost
      for (index, entry) in _availUpgrades.enumerate() {
        if entry == upgrade.name {
          _availUpgrades.removeAtIndex(index)
        }
      }
      return true
    } else {
      return false
    }
  }
  
  func removeUpgrade(upgrade: UpgradeCard) -> Bool {
    if _currentUpgrades.contains(upgrade.name) {
      _currentUpgrades.removeAtIndex(_currentUpgrades.indexOf(upgrade.name)!)
      _availUpgrades.append(upgrade.type.rawValue)
      //TODO: also must remove upgrade cost from current point cost
      return true
    } else {
      return false
    }
  }
  
  func clearUpgrades() {
    _availUpgrades = _originalUpgrades
    _currentUpgrades.removeAll()
    currentPointCost = startingPointCost
  }
  
}