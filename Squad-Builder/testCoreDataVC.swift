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

    override func viewDidLoad() {
        super.viewDidLoad()

      seedSquad()
      fetchSquad()
        // Do any additional setup after loading the view.
    }

  func seedSquad() {
    let moc = DataController().managedObjectContext
    let entity = NSEntityDescription.insertNewObjectForEntityForName("SquadEntity", inManagedObjectContext: moc) as! Squad
    entity.setValue("Drew", forKey: "name")
    entity.setValue("Rebel", forKey: "faction")
    entity.setValue(36, forKey: "pointCost")
    entity.setValue("nothing here yet", forKey: "ships")
    
    do {
      try moc.save()
      print("saved")
    } catch {
      fatalError("Failure to save context: \(error)")
    }
  }
  
  func fetchSquad() {
    let moc = DataController().managedObjectContext
    let squadFetch = NSFetchRequest(entityName: "SquadEntity")
    
    do {
      let fetchedSquad = try moc.executeFetchRequest(squadFetch) as! [Squad]
      print("fetched \(fetchedSquad.first!.name!)")
    } catch {
      fatalError("Failed to fetch any squads. \(error)")
    }
  }

}
