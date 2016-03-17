//
//  SquadronCreateVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class SquadronCreateVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FactionSelectDelegate {

  var squadrons = [Squadron]()
  let promptSquad = Squadron(name: "Tap To Create Squadron", faction: .Rebel)
  var selectedFaction: Faction!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var factionSelectView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      squadrons.insert(promptSquad, atIndex: 0)
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
      selectFaction()
    } else {
      performSegueWithIdentifier("newSquadron", sender: tableView)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "newSquadron" {
      if let destination = segue.destinationViewController as? SquadBuildVC {
        if let table = sender as? UITableView {
          if (table.indexPathForSelectedRow?.row) == 0 {
            destination.squadron = Squadron(name: "\(self.selectedFaction) Squad", faction: self.selectedFaction)
          } else {
            destination.squadron = squadrons[(table.indexPathForSelectedRow?.row)!]
          }
        }
      }
    }
  }
  
  func selectFaction() {
    
    if let customView = NSBundle.mainBundle().loadNibNamed("FactionSelect", owner: self, options: nil).first as? FactionSelect {
      let popupFrame = CGRect(x: self.view.frame.size.width/2 - customView.frame.width/2, y: self.view.frame.size.height/2-customView.frame.height/2, width: customView.frame.width, height: customView.frame.height)
      customView.layer.cornerRadius = 10.0
      customView.clipsToBounds = true
      customView.frame = popupFrame
      self.view.addSubview(customView)
      factionSelectView = customView
      customView.factionSelectDelegate = self
    }
  }
  
  func factionSelected(faction: Faction) {
    self.selectedFaction = faction
    performSegueWithIdentifier("newSquadron", sender: tableView)
    factionSelectView.removeFromSuperview()
  }
}
