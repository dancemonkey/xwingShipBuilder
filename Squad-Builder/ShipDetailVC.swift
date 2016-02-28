//
//  ShipDetailVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipDetailVC: UIViewController, PilotSelectedDelegate, UpgradeSelectedDelegate {

  @IBOutlet weak var shipBtn: RoundButton!
  @IBOutlet weak var pilotLbl: UILabel!
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var upgradeView: UIView!
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var evade: UILabel!
  @IBOutlet weak var hull: UILabel!
  @IBOutlet weak var shield: UILabel!
  @IBOutlet weak var factionImg: UIImageView!
  @IBOutlet weak var pointCost: PointCostUILbl!
  @IBOutlet weak var cardText: UITextView!
  
  var buttonBackground: String!
  var pilot: PilotCard!
  var pilotsForShipType = [String]()
  var ships: ShipData!
  
  var upgradeSelected: Int = 0
  
    override func viewDidLoad() {
      super.viewDidLoad()
      ships = ShipData()
      shipBtn.setBackgroundImage(UIImage(named: buttonBackground), forState: .Normal)
      initializePilotData()
      setupFactionImageView()
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func initializePilotData() {
    shipBtn.setTitle(pilot.pilotName, forState: .Normal)
    loadUpgradeIcons()
    loadActionIcons()
    setStats()
    cardText.text = pilot.cardText
    cardText.font = UIFont(name: "Helvetica-Oblique", size: 16.0)
    cardText.textColor = UIColor.lightGrayColor()
  }

  func loadUpgradeIcons() -> Bool {
    for view in upgradeView.subviews {
      view.removeFromSuperview()
    }
    
    guard let _ = pilot.pilotName else {
      return false
    }
    for (index,upgrade) in pilot.availUpgrades.enumerate() {
      let img = UIImage(named: upgrade)
      let WIDTH = 40
      let HEIGHT = WIDTH
      let button = UIButton(frame: CGRect(x: index*WIDTH, y: 0, width: WIDTH, height: HEIGHT))
      button.setBackgroundImage(img, forState: .Normal)
      button.tag = index
      button.addTarget(self, action: "upgradeButtonTapped:", forControlEvents: .TouchUpInside)
      upgradeView.addSubview(button)
      upgradeView.backgroundColor = UIColor.clearColor()
    }
    return true
  }
  
  func loadActionIcons() -> Bool {
    for view in actionView.subviews {
      view.removeFromSuperview()
    }
    
    guard let _ = pilot.pilotName else {
      return false
    }
    for (index, action) in pilot.actions.enumerate() {
      let img = UIImage(named: action.rawValue)
      let WIDTH = 40
      let HEIGHT = WIDTH
      let imgView = RoundImageView(image: img)
      imgView.frame = CGRect(x: index*WIDTH, y: 0, width: WIDTH, height: HEIGHT)
      actionView.addSubview(imgView)
      imgView.awakeFromNib()
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
    pointCost.text = String(pilot.currentPointCost)
  }
  
  func setupFactionImageView() {
    factionImg.image = UIImage(named: pilot.faction)
    factionImg.alpha = 0.25
  }
  
  func upgradeButtonTapped(sender: UIButton!) {
    upgradeSelected = sender.tag
    performSegueWithIdentifier("UpgradeSelect", sender: self)
  }
  
  func userSelectedNewPilot(name: String) {
    self.pilot = PilotCard(ship: self.pilot.shipType, pilot: name)
    initializePilotData()
  }
  
  func userSelectedUpgrade(type: UpgradeCard) {
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PilotSelect" {
      let destination = segue.destinationViewController as? PilotSelectVC
      destination?.pilots = self.pilotsForShipType
      destination?.delegate = self
      destination?.shipType = self.pilot.shipType
    } else if segue.identifier == "UpgradeSelect" {
      let destination = segue.destinationViewController as? UpgradeSelectVC
      destination?.delegate = self
      destination?.upgradeType = pilot.availUpgrades[upgradeSelected]
    }
  }
}
