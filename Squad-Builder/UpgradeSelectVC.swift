//
//  UpgradeSelectVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/27/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: tapping a cell dismisses VC and loads upgrades into selected ship

import UIKit

class UpgradeSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var availableUpgrades = [UpgradeCard]()
  var upgradeType: String!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var upgradeTypeLabel: UILabel!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.dataSource = self
      tableView.delegate = self
      
      availableUpgrades = findAvailableUpgrades(forType: upgradeType)
      
      upgradeTypeLabel.text = "Select \(upgradeType)"
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("upgradeCell") as? UpgradeCell {
      cell.configureCell(withUpgrade: availableUpgrades[indexPath.row])
      return cell
    } else {
      return UpgradeCell()
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return availableUpgrades.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func findAvailableUpgrades(forType type: String) -> [UpgradeCard] {
    let allUpgrades = UpgradeData()
    var availUpgrades = [UpgradeCard]()
    for upgrade in allUpgrades.upgrades {
      if upgrade.type == UpgradeType(rawValue: type) {
        availUpgrades.append(UpgradeCard(name: upgrade.name))
      }
    }
    return availUpgrades
  }

}
