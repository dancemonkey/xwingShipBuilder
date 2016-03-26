//
//  DataController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/25/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
  
  var managedObjectContext: NSManagedObjectContext
  
  override init() {
    guard let modelURL = NSBundle.mainBundle().URLForResource("SquadModel", withExtension: "momd") else {
      fatalError("Error loading model from bundle.")
    }
    
    guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
      fatalError("Error initializing mom from \(modelURL)")
    }
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    self.managedObjectContext.persistentStoreCoordinator = psc
    
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    let docURL = urls[urls.endIndex-1]
    let storeURL = docURL.URLByAppendingPathComponent("SquadModel.sqlite")
    do {
      try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
    } catch {
      fatalError("Error migrating store: \(error)")
    }
    
  }
}
