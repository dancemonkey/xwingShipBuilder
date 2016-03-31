//
//  UpgradeCard.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/3/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: implement upgrade effects and test for limitations

import Foundation

class UpgradeCard: NSObject, NSCoding {
  private let _upgradeCard: UpgradeData.Upgrade!
  
  var text: String {
    get {
      return _upgradeCard.text
    }
  }
  
  var pointCost: Int {
    get {
      return _upgradeCard.pointCost
    }
  }
  
  var name: String {
    get {
      return _upgradeCard.name
    }
  }
  
  var limitation: String {
    get {
      return _upgradeCard.limitation
    }
  }
  
  var effect: String {
    get {
      return _upgradeCard.effect
    }
  }
  
  var type: UpgradeType {
    get {
      return _upgradeCard.type
    }
  }
  
  init(name: String) {
    let upgrades = UpgradeData()
    _upgradeCard = upgrades.getUpgrade(name)
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard let upgrade = aDecoder.decodeObjectForKey("upgradeName") as? String else {
      fatalError("no upgrade found")
    }
    
    let upgrades = UpgradeData()
    self._upgradeCard = upgrades.getUpgrade(upgrade)
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.name, forKey: "upgradeName")
  }
  
}