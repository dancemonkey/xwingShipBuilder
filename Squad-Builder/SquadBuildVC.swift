//
//  SquadBuildVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class SquadBuildVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var squadNameLbl: UILabel!
  
  var squadron: Squadron!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      squadNameLbl.text = squadron.name
    }

  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: Tableview junk
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return squadron.ships.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("shipCell") as? SquadShipCell {
      return cell
    } else {
      return SquadShipCell()
    }
  }
}
