//
//  PilotSelectVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/23/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

protocol PilotSelectedDelegate: class {
  func userSelectedNewPilot(name: String)
}

class PilotSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  weak var delegate: PilotSelectedDelegate? = nil
  
  var pilots = [String]()
  var shipType: String!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pilots.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("pilotCell") {
      cell.textLabel!.text = pilots[indexPath.row]
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    dismissViewControllerAnimated(true, completion: nil)
    delegate?.userSelectedNewPilot(pilots[indexPath.row])
  }
}
