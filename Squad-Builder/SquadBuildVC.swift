//
//  SquadBuildVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

protocol SquadSaveDelegate {
  func saveToSquadList(squad: Squadron)
}

import UIKit

class SquadBuildVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var squadNameLbl: UILabel!
  
  var squadron: Squadron!
  var faction: Faction!
  
  var delegate: SquadSaveDelegate!
  
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
    } else if segue.identifier == "loadShipFromSquad" {
      if let destination = segue.destinationViewController as? ShipDetailVC {
        destination.pilot = squadron.ships[(sender as! Int)]
        destination.squadIndex = sender as? Int
      }
    }
  }
  
  @IBAction func unwindToHere(segue: UIStoryboardSegue) {
    if let previousVC = segue.sourceViewController as? ShipDetailVC {
      squadron.addPilot(previousVC.pilot, atIndex: previousVC.squadIndex)
      tableView.reloadData()
    }
  }
  
  @IBAction func donePressed(sender: UIButton) {
    delegate.saveToSquadList(squadron)
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func nameLblTapped(sender: AnyObject) {
    let whitespace = NSCharacterSet.whitespaceCharacterSet()
    let renamePopup = UIAlertController(title: "Rename Squad?", message: "Enter a new name for your squad.", preferredStyle: .Alert)
    let doneAction = UIAlertAction(title: "Done", style: .Default) { (action) -> Void in
      if let newName = renamePopup.textFields?.first?.text where newName.stringByTrimmingCharactersInSet(whitespace) != "" {
        self.squadron.name = newName
        self.squadNameLbl.text = self.squadron.name
      }
    }
    renamePopup.addAction(doneAction)
    renamePopup.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    renamePopup.addTextFieldWithConfigurationHandler { (textField) -> Void in
      textField.placeholder = "Enter a new squad name..."
    }
    presentViewController(renamePopup, animated: true, completion: nil)
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
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("loadShipFromSquad", sender: indexPath.row)
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    squadron.removePilot(atIndex: indexPath.row)
    tableView.reloadData()
  }
}
