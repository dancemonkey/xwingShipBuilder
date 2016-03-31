//
//  testCoreDataVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/25/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

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
  
  func fetchSquads() -> [Squadron] {
    
    let moc = DataController().managedObjectContext
    let squadFetch = NSFetchRequest(entityName: "SquadEntity")
    var squadArray = [Squadron]()
    
    do {
      let fetchedSquad = try moc.executeFetchRequest(squadFetch) as! [Squad]
      
      for squad in fetchedSquad {
        let new = Squadron(name: squad.name!, pointCost: Int(squad.pointCost!), faction: Faction(rawValue: squad.faction!)!)
        for (i, pilot) in squad.ships.enumerate() {
          new.addPilot(pilot as! PilotCard, atIndex: i)
        }
        squadArray.append(new)
      }
    } catch {
      fatalError("Error fetching squads. \(error)")
    }
    
    return squadArray
    
  }

}
