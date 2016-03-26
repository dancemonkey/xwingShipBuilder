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

}
