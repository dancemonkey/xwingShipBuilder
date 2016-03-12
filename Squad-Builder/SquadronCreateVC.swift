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
  @IBOutlet weak var factionSelectView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      squadrons.insert(promptSquad, atIndex: 0)
      squadrons.append(testSquad)
      selectFaction()
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
    performSegueWithIdentifier("newSquadron", sender: tableView)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "newSquadron" {
      if let destination = segue.destinationViewController as? SquadBuildVC {
        if let table = sender as? UITableView {
          if (table.indexPathForSelectedRow?.row) == 0 {
            destination.squadron = Squadron(name: "New Squad", faction: .Rebel)
          } else {
            destination.squadron = squadrons[(table.indexPathForSelectedRow?.row)!]
          }
        }
      }
    }
  }
  
  func selectFaction() -> Faction {
    
    if let customView = NSBundle.mainBundle().loadNibNamed("FactionSelect", owner: self, options: nil).first as? FactionSelect {
      factionSelectView.addSubview(customView)
      factionSelectView.hidden = false
    }
    return .Rebel
  }
}
