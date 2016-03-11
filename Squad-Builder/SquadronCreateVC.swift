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
  
  @IBOutlet weak var tableView: UITableView!
  
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
      cell.configureCell(withSquadron: Squadron(name: "Tap To Create Squadron", faction: .Rebel))
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
}
