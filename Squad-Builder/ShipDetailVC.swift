//
//  ShipDetailVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: Create nil pilot name type for each ship type that loads initially. If nil pilot, btn text says to load pilot, no stats, upgrades, etc.

import UIKit

class ShipDetailVC: UIViewController {

  @IBOutlet weak var shipBtn: RoundButton!
  @IBOutlet weak var pilotLbl: UILabel!
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var upgradeView: UIView!
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var evade: UILabel!
  @IBOutlet weak var hull: UILabel!
  @IBOutlet weak var shield: UILabel!
  
  var buttonBackground: String!
  var pilot: PilotCard!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      shipBtn.awakeFromNib()
      shipBtn.setBackgroundImage(UIImage(named: buttonBackground), forState: .Normal)
      shipBtn.setTitle(pilot.pilotName, forState: .Normal)
      loadUpgradeIcons()
      loadActionIcons()
      setStats()
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  func loadUpgradeIcons() -> Bool {
    guard let _ = pilot.pilotName else {
      return false
    }
    for (index,upgrade) in pilot.availUpgrades.enumerate() {
      let img = UIImage(named: upgrade)
      let WIDTH = 40
      let HEIGHT = WIDTH
      let button = UIButton(frame: CGRect(x: index*WIDTH, y: 0, width: WIDTH, height: HEIGHT))
      button.setBackgroundImage(img, forState: .Normal)
      upgradeView.addSubview(button)
      upgradeView.backgroundColor = UIColor.clearColor()
    }
    return true
  }
  
  func loadActionIcons() -> Bool {
    guard let _ = pilot.pilotName else {
      return false
    }
    for (index, action) in pilot.actions.enumerate() {
      let img = UIImage(named: action.rawValue)
      let WIDTH = 40
      let HEIGHT = WIDTH
      let button = RoundButton(frame: CGRect(x: index*WIDTH, y: 0, width: WIDTH, height: HEIGHT))
      button.setBackgroundImage(img, forState: .Normal)
      actionView.addSubview(button)
      button.awakeFromNib()
      actionView.backgroundColor = UIColor.clearColor()
    }
    return true
  }
  
  func setStats() {
    guard let _ = pilot.pilotName else {
      attack.text = "-"
      evade.text = "-"
      hull.text = "-"
      shield.text = "-"
      return
    }
    attack.text = String(pilot.shipStats.attack)
    evade.text = String(pilot.shipStats.evade)
    hull.text = String(pilot.shipStats.hull)
    shield.text = String(pilot.shipStats.shield)
  }
}
