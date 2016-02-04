//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let newShip = PilotCard(ship: "X-Wing", pilot: "Luke Skywalker")
    let hlc = UpgradeCard(name: "Engine Upgrade")
    print(hlc.limitation)
    print(hlc.effect)
  }

}

