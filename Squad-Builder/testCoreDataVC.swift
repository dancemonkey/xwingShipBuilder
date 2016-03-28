//
//  testCoreDataVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/25/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

// TODO: next step is to move this into main app so it can be used by main squad list

import UIKit
import CoreData

class testCoreDataVC: UIViewController {
  
  let pilot = PilotCard(ship: "Firespray-31", pilot: "Boba Fett")
  let squad = Squadron(name: "Test", faction: .Scum)

    override func viewDidLoad() {
      super.viewDidLoad()
      
      //test for core data saving and fetching
      squad.addPilot(pilot, atIndex: nil)

      seedSquad() // make sure doesn't already exist in store before saving?
      fetchSquads()
    }

  func seedSquad() {
    let moc = DataController().managedObjectContext
    let entity = NSEntityDescription.insertNewObjectForEntityForName("SquadEntity", inManagedObjectContext: moc) as! Squad
    entity.setValue(squad.name, forKey: "name")
    entity.setValue(squad.faction.rawValue, forKey: "faction")
    entity.setValue(squad.pointCost, forKey: "pointCost")
    entity.setValue(squad.ships, forKey: "ships")
    
    do {
      try moc.save()
    } catch {
      fatalError("Failure to save context: \(error)")
    }
  }
  
  func fetchSquads() {
    
    let moc = DataController().managedObjectContext
    let squadFetch = NSFetchRequest(entityName: "SquadEntity")
    
    do {
      let fetchedSquad = try moc.executeFetchRequest(squadFetch) as! [Squad]
      
      let newSquad = Squadron(name: fetchedSquad.first!.name!, pointCost: Int((fetchedSquad.first?.pointCost)!), faction: Faction(rawValue: fetchedSquad.first!.faction!)!)
      for (i,pilot) in ((fetchedSquad.first?.ships)!).enumerate() {
        newSquad.addPilot(pilot as! PilotCard, atIndex: i)
      }
    } catch {
      fatalError("Failed to fetch any squads. \(error)")
    }
  }

}
