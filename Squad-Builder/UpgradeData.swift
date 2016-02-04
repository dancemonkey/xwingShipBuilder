//
//  UpgradeData.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/3/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation
import UIKit

enum UpgradeType: String {
  case Elite, Astromech, Torpedoes, Missiles, Cannon, Turret, Bomb, Crew, SalvagedAstromech, System, Title, Modification, Illicit, Cargo, Hardpoint, Team, Tech
}

class UpgradeData {
  let url: NSURL!
  let data: NSData!
  struct Upgrade {
    let type: UpgradeType!
    let name: String!
    let pointCost: Int!
    let text: String!
    let effect: String!
    let limitation: String!
  }
  var upgrades = [Upgrade]()
  
  init() {
    url = NSBundle.mainBundle().URLForResource("upgrades_json", withExtension: "json")
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
    guard let upgrades = object["upgrades"] as? [[String: AnyObject]] else { return }
    
    for upgrade in upgrades {
      guard let name = upgrade["upgrade"] as? String else { break }
      let upgrade_type = upgrade["type"] as! String
      let cost = upgrade["pointCost"] as! Int
      let text = upgrade["text"] as! String
      let effect = upgrade["effect"] as! String
      let limitation = upgrade["limitation"] as! String
      
      let newShip = Upgrade(type: UpgradeType(rawValue: upgrade_type), name: name, pointCost: cost, text: text, effect: effect, limitation: limitation)
      self.upgrades.append(newShip)
    }
  }
  
  func getUpgrade(named: String) -> Upgrade? {
    for upgrade in upgrades {
      if upgrade.name == named {
        return upgrade
      }
    }
    return nil
  }

}