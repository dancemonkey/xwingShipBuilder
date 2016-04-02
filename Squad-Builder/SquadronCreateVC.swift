//
//  SquadronCreateVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class SquadronCreateVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FactionSelectDelegate, SquadSaveDelegate
{

  var squadrons = [Squadron]()
  var selectedFaction: Faction!
  let moc = DataController().managedObjectContext
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var factionSelectView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    print(fetchAllSquads().count)
  }
  
  override func viewWillAppear(animated: Bool) {
    //squadrons = fetchAllSquads()
    tableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "newSquadron" {
      if let destination = segue.destinationViewController as? SquadBuildVC {
        destination.delegate = self
        if let table = sender as? UITableView {
          destination.squadron = squadrons[(table.indexPathForSelectedRow?.row)!]
        } else if sender == nil {
          destination.squadron = Squadron(name: "\(self.selectedFaction) Squad", faction: self.selectedFaction, context: self.moc)
        }
      }
    }
    
  }
  
  @IBAction func newSquadPressed(sender: UIButton) {
    selectFaction()
  }
  
  func saveToSquadList(squad: Squadron) {
    var found = false
    for (index,s) in squadrons.enumerate() {
      if s === squad {
        squadrons[index] = squad
        found = true
      }
    }
    if !found {
      squadrons.append(squad)
    }
    saveSquadronList()
    tableView.reloadData()
  }
  
  func saveSquadronList() {
    do {
      try moc.save()
    } catch {
      fatalError("Failure to save context: \(error)")
    }
  }
  
  /*func fetch(squadronNamed name: String) -> Squad? {
    let squadFetch = NSFetchRequest(entityName: "SquadEntity")
    do {
      let result = try moc.executeFetchRequest(squadFetch) as? [Squad]
      if result != nil {
        for squad in result! {
          if squad.name == name {
            return squad
          }
        }
      }
    } catch {
      fatalError("big problem searching for a single squad")
    }
    return nil
  }*/
  
  func fetchAllSquads() -> [Squadron] {
    
    let squadFetch = NSFetchRequest(entityName: "SquadEntity")
    var squadArray = [Squadron]()
    
    do {
      let fetchedSquad = try moc.executeFetchRequest(squadFetch) as! [Squadron]
      squadArray = fetchedSquad
    } catch {
      fatalError("Error fetching squads. \(error)")
    }
    
    return squadArray
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
    performSegueWithIdentifier("newSquadron", sender: nil)
    factionSelectView.removeFromSuperview()
  }
  
  // MARK: Tableview junk
  
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
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    squadrons.removeAtIndex(indexPath.row)
    tableView.reloadData()
  }
}
