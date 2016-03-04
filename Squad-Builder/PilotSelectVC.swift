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
      searchBar.returnKeyType = .Done
      searchBar.setShowsCancelButton(false, animated: false)
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
    if searching {
      delegate?.userSelectedNewPilot(filteredPilots[indexPath.row])
    } else {
      delegate?.userSelectedNewPilot(pilots[indexPath.row])
    }
  }
  
  // MARK: SearchBar junk
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text == nil || searchBar.text == "" {
      searching = false
      view.endEditing(true)
      self.tableView.reloadData()
    } else {
      searching = true
      filteredPilots = pilots.filter({ (pilot) -> Bool in
        return pilot.lowercaseString.containsString(searchText.lowercaseString)
      })
      self.tableView.reloadData()
    }
  }
  
  func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  
  func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(false, animated: true)
    return true
  }
  
  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    searching = false
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    self.searchBar.text = ""
    searching = false
    self.tableView.reloadData()
    view.endEditing(true)
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    view.endEditing(true)
    searching = false
  }

}
