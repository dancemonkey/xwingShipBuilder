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

class PilotCard: NSObject, NSCoding {
  
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
  private var _currentUpgrades = [UpgradeCard]()
  var currentUpgrades: [UpgradeCard] {
    get {
        return _currentUpgrades
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
    var agility: Int
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
    _shipStats = Stats(attack: _shipCard.stat_Attack, agility: _shipCard.stat_Agility, hull: _shipCard.stat_Hull, shield: _shipCard.stat_Shield)
    currentPointCost = _shipCard.pointCost
  }
  
  func attachUpgrade(upgrade: UpgradeCard) -> Bool {
    if _availUpgrades.contains(upgrade.type.rawValue) {
      _currentUpgrades.append(upgrade)
      for (index, entry) in _availUpgrades.enumerate() {
        if entry == upgrade.type.rawValue {
          _availUpgrades.removeAtIndex(index)
        }
      }
      return true
    } else {
      return false
    }
  }
  
  func removeUpgrade(upgrade: UpgradeCard) -> Bool {
    if _currentUpgrades.contains({upgrade.name == $0.name}) {
      _currentUpgrades.removeAtIndex(_currentUpgrades.indexOf({upgrade.name == $0.name})!)
      _availUpgrades.append(upgrade.type.rawValue)
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
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(shipType, forKey: "shipType")
    aCoder.encodeObject(pilotName, forKey: "pilotName")
    aCoder.encodeObject(_currentUpgrades, forKey: "currentUpgrades")
    aCoder.encodeObject(_availUpgrades, forKey: "availableUpgrades")
    aCoder.encodeObject(_originalUpgrades, forKey: "originalUpgrades")
    aCoder.encodeObject(currentPointCost, forKey: "currentPointCost")
    aCoder.encodeObject(_shipStats! as? AnyObject, forKey: "shipStats")
    for (index,action) in _actions.enumerate() {
      aCoder.encodeObject(action.rawValue, forKey: "action\(index)")
    }
    aCoder.encodeObject(_actions.count, forKey: "actionCount")
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let ship = aDecoder.decodeObjectForKey("shipType") as? String, let name = aDecoder.decodeObjectForKey("pilotName") as? String else {
      fatalError("no ship found in core data")
    }
    self._shipCard = ShipData().getShip(ofType: ship, withPilot: name)
    self._currentUpgrades = (aDecoder.decodeObjectForKey("currentUpgrades") as? [UpgradeCard])!
    self._availUpgrades = (aDecoder.decodeObjectForKey("availableUpgrades") as? [String])!
    self._availUpgrades = (aDecoder.decodeObjectForKey("originalUpgrades") as? [String])!
    self.currentPointCost = (aDecoder.decodeObjectForKey("currentPointCost") as? Int)!
    self._shipStats = aDecoder.decodeObjectForKey("shipStats") as? PilotCard.Stats
    self._actions = [Actions]()
    if let actionCount = aDecoder.decodeObjectForKey("actionCount") as? Int {
      for i in 0..<actionCount {
        let ac = aDecoder.decodeObjectForKey("action\(i)") as? String
        self._actions.append(Actions(rawValue: ac!)!)
      }
    }
  }
}