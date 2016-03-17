//
//  SquadBuildVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: name squad
//TODO: save squad to main squad list

import UIKit

class SquadBuildVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var squadNameLbl: UILabel!
  
  var squadron: Squadron!
  var faction: Faction!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      squadNameLbl.text = squadron.name
      faction = squadron.faction
      
      tableView.delegate = self
      tableView.dataSource = self
      
  }

  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func newSquadPressed(sender: UIButton) {
    performSegueWithIdentifier("shipSelect", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "shipSelect" {
      if let destination = segue.destinationViewController as? ShipSelectVC {
        destination.squadVC = self
        destination.selectedFaction = self.faction
      }
    }
  }
  
  @IBAction func unwindToHere(segue: UIStoryboardSegue) {
    if let previousVC = segue.sourceViewController as? ShipDetailVC {
      squadron.addPilot(previousVC.pilot)
      tableView.reloadData()
    }
  }
  
  // MARK: Tableview junk
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return squadron.ships.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("shipCell") as? SquadShipCell {
      cell.configureCell(withPilot: squadron.ships[indexPath.row])
      return cell
    } else {
      return SquadShipCell()
    }
  }
}
