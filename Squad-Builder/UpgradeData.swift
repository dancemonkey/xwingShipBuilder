//
//  UpgradeData.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/3/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation
import UIKit

//TODO: change this around to be an Upgrade rather than Ship card
//TODO: add UpgradeCard class type

class UpgradeData {
  let url: NSURL!
  let data: NSData!
  struct Ship {
    let shipType: String!
    let pilotName: String!
    let pilotSkill: Int!
    let faction: Faction!
    let stat_Attack: Int!
    let stat_Evade: Int!
    let stat_Hull: Int!
    let stat_Shield: Int!
    let text: String!
    let avail_Upgrades: [String]!
    let avail_Actions: [Actions]!
    let pointCost: Int!
  }
  var ships = [Ship]()
  
  init() {
    url = NSBundle.mainBundle().URLForResource("ship_data_json", withExtension: "json")
    data = NSData(contentsOfURL: url)
    
    do {
      let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
      if let dictionary = object as? [String: AnyObject] {
        readJSONObject(dictionary)
      }
    } catch {
      print("didn't find shit")
    }
  }
  
  func readJSONObject(object: [String: AnyObject]) {
    guard let ships = object["ships"] as? [[String: AnyObject]] else { return }
    
    for ship in ships {
      guard let pilot = ship["pilot"] as? String else { break }
      let ship_type = ship["ship_type"] as! String
      let ps = ship["ps"] as! Int
      let faction = Faction(rawValue: ship["faction"] as! String)
      let s_a = ship["attack"] as! Int
      let s_e = ship["evade"] as! Int
      let s_h = ship["hull"] as! Int
      let s_s = ship["shield"] as! Int
      let text = ship["text"] as! String
      let upgrades = ship["avail_upgrades"] as! [String]
      var actions = [Actions]()
      for value in (ship["avail_actions"] as! NSArray) {
        actions.append(Actions(rawValue: value as! String)!)
      }
      let points = ship["point_cost"] as! Int
      
      let newShip = Ship(shipType: ship_type, pilotName: pilot, pilotSkill: ps, faction: faction, stat_Attack: s_a, stat_Evade: s_e, stat_Hull: s_h, stat_Shield: s_s, text: text, avail_Upgrades: upgrades, avail_Actions: actions, pointCost: points)
      self.ships.append(newShip)
    }
  }
  
  func getShip(ofType type: String, withPilot: String) -> Ship? {
    for ship in ships {
      if ship.shipType == type && ship.pilotName == withPilot {
        return ship
      }
    }
    return nil
  }

}