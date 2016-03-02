//
//  UpgradeSelectVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/27/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: need squad creation screen that leads to ship select screen, etc.

import UIKit

protocol UpgradeSelectedDelegate: class {
  func userSelectedUpgrade(type: UpgradeCard)
}

class UpgradeSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  var availableUpgrades = [UpgradeCard]()
  var filteredUpgrades = [UpgradeCard]()
  var upgradeType: String!
  var searching = false
  
  weak var delegate: UpgradeSelectedDelegate? = nil
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var upgradeTypeLabel: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.dataSource = self
      tableView.delegate = self
      searchBar.delegate = self
      
      availableUpgrades = findAvailableUpgrades(forType: upgradeType)
      
      upgradeTypeLabel.text = "Select \(upgradeType)"
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
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
  
  // MARK: TableView junk
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("upgradeCell") as? UpgradeCell {
      if searching {
        cell.configureCell(withUpgrade: filteredUpgrades[indexPath.row])
      } else {
        cell.configureCell(withUpgrade: availableUpgrades[indexPath.row])
      }
      return cell
    } else {
      return UpgradeCell()
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching {
      return filteredUpgrades.count
    } else {
      return availableUpgrades.count
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    delegate?.userSelectedUpgrade(availableUpgrades[indexPath.row])
    dismissViewControllerAnimated(true, completion: nil)
  }

  // MARK: SearchBar junk
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    filteredUpgrades = availableUpgrades.filter({ (upgrade) -> Bool in
      return upgrade.name.lowercaseString.containsString(searchText.lowercaseString) || upgrade.text.lowercaseString.containsString(searchText.lowercaseString)
    })
    if filteredUpgrades.count == 0 {
      searching = false
    } else {
      searching = true
    }
    self.tableView.reloadData()
  }
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searching = true
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searching = false
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searching = false
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searching = false
  }

}
