//
//  ShipDetailVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipDetailVC: UIViewController, PilotSelectedDelegate, UpgradeSelectedDelegate, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var shipBtn: RoundButton!
  @IBOutlet weak var pilotLbl: UILabel!
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var upgradeView: UIView!
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var agility: UILabel!
  @IBOutlet weak var hull: UILabel!
  @IBOutlet weak var shield: UILabel!
  @IBOutlet weak var factionImg: UIImageView!
  @IBOutlet weak var pointCost: PointCostUILbl!
  @IBOutlet weak var cardText: UITextView!
  
  @IBOutlet weak var tableView: UITableView!
  
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
      
      tableView.delegate = self
      tableView.dataSource = self
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
      agility.text = "-"
      hull.text = "-"
      shield.text = "-"
      return
    }
    attack.text = String(pilot.shipStats.attack)
    agility.text = String(pilot.shipStats.agility)
    hull.text = String(pilot.shipStats.hull)
    shield.text = String(pilot.shipStats.shield)
    pointCost.text = String(pilot.currentPointCost)
    pointCost.setOriginalPointValue(withValue: pilot.startingPointCost)
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
    self.pilot.clearUpgrades()
    initializePilotData()
    tableView.reloadData()
  }
  
  func userSelectedUpgrade(type: UpgradeCard) {
    pilot.attachUpgrade(type)
    loadUpgradeIcons()
    tableView.reloadData()
    updatePointCost(withValue: type.pointCost)
  }
  
  func updatePointCost(withValue value: Int) {
    pilot.currentPointCost += value
    pointCost.text = String(pilot.currentPointCost)
    if String(pointCost.originalPointValue) != pointCost.text! {
      pointCost.textColor = UIColor.redColor()
    } else if String(pointCost.originalPointValue) == pointCost.text! {
      pointCost.textColor = UIColor.darkGrayColor()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PilotSelect" {
      var pilots = [PilotCard]()
      for pilot in pilotsForShipType {
        pilots.append(PilotCard(ship: self.pilot.shipType, pilot: pilot))
      }
      
      let destination = segue.destinationViewController as? PilotSelectVC
      destination?.pilots = pilots
      destination?.delegate = self
      destination?.shipType = self.pilot.shipType
    } else if segue.identifier == "UpgradeSelect" {
      let destination = segue.destinationViewController as? UpgradeSelectVC
      destination?.delegate = self
      destination?.upgradeType = pilot.availUpgrades[upgradeSelected]
    }
  }
  
  //MARK: TableView junk
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("ShipUpgradeCell") as? ShipUpgradeCell {
      cell.configureCell(withUpgrade: pilot.currentUpgrades[indexPath.row])
      return cell
    } else {
      return ShipUpgradeCell()
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pilot.currentUpgrades.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    updatePointCost(withValue: -pilot.currentUpgrades[indexPath.row].pointCost)
    pilot.removeUpgrade(pilot.currentUpgrades[indexPath.row])
    tableView.reloadData()
    loadUpgradeIcons()
  }
}
