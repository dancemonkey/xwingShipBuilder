//
//  SquadronCreateVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class SquadronCreateVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var squadrons = [Squadron]()
  let promptSquad = Squadron(name: "Tap To Create Squadron", faction: .Rebel)
  let testSquad = Squadron(name: "test", faction: .Scum)
  
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      squadrons.insert(promptSquad, atIndex: 0)
      squadrons.append(testSquad)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return squadrons.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("SquadronCell") as? SquadronCell {
      cell.configureCell(withSquadron: squadrons[indexPath.row])
      return cell
    } else {
      return SquadronCell()
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 0 {
      performSegueWithIdentifier("newSquadron", sender: self)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // USE THIS IF BUILDING A NEW SQUAD FROM SCRATCH
    if segue.identifier == "newSquadron" {
      if let destination = segue.destinationViewController as? SquadBuildVC {
        destination.squadName = "New Squad"
      }
      
    // IF LOADING EXISTING SQUAD TRY AND PULL THE NAME FROM THE INDEXPATH OF THE SELECTED ROW. HOPE THIS WORKS NEVER USED IT
    } else if segue.identifier == "loadSquadron" {
      if let destination = segue.destinationViewController as? SquadBuildVC {
        if let table = sender as? UITableView {
          destination.squadName = squadrons[(table.indexPathForSelectedRow?.row)!].name
        }
      }
    }
  }
}
