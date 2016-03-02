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

class PilotSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  weak var delegate: PilotSelectedDelegate? = nil
  
  var pilots = [String]()
  var filteredPilots = [String]()
  var shipType: String!
  var searching = false
  
    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      
      searchBar.delegate = self
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: TableView junk
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searching {
      return filteredPilots.count
    } else {
      return pilots.count
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("pilotCell") {
      if searching {
        cell.textLabel!.text = filteredPilots[indexPath.row]
      } else {
        cell.textLabel!.text = pilots[indexPath.row]
      }
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    dismissViewControllerAnimated(true, completion: nil)
    delegate?.userSelectedNewPilot(pilots[indexPath.row])
  }
  
  // MARK: SearchBar junk
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    filteredPilots = pilots.filter({ (pilot) -> Bool in
      return pilot.lowercaseString.containsString(searchText.lowercaseString)
    })
    if filteredPilots.count == 0 {
      searching = false
    } else {
      searching = true
    }
    self.tableView.reloadData()
  }
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searching = true
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searching = false
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searching = false
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searching = false
  }

}
