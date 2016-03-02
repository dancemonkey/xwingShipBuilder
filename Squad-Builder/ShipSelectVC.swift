//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: divide ships into factions on ship select VC
//???: holding upgrade button pops up a tooltip telling what it does?
//TODO: ship factions and data pull from JSON, but in dictionary (values must be tied together in order)

import UIKit

class ShipSelectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let WIDTH: CGFloat = 150
  let HEIGHT: CGFloat = 150
  var SHIP_TYPES = [String]()
  var filteredShipTypes = [String]()
  let SHIP_FACTIONS: [String] = ["Scum","Imperial","Rebel"] 
  var selectedShipTitle: String!
  var ships: ShipData!
  
  var searching = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ships = ShipData()
    SHIP_TYPES = ships.getAllShipTypes()
    
    collection.delegate = self
    collection.dataSource = self
    
    searchBar.delegate = self
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let destVC = segue.destinationViewController as! ShipDetailVC
    destVC.buttonBackground = selectedShipTitle
    destVC.pilot = PilotCard(ship: selectedShipTitle, pilot: nil)
    destVC.pilotsForShipType = ships.getPilots(selectedShipTitle)
  }
  
  // MARK: CollectionView junk
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("shipCell", forIndexPath: indexPath) as? ShipCollectionViewCell {
      if searching {
        cell.configureCell(filteredShipTypes[indexPath.row])
      } else {
        cell.configureCell(SHIP_TYPES[indexPath.row])
      }
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searching {
      return filteredShipTypes.count
    } else {
      return SHIP_TYPES.count
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 150.0, height: 150.0)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    selectedShipTitle = SHIP_TYPES[indexPath.row]
    performSegueWithIdentifier("showShipDetail", sender: self)
  }
  
  // MARK: SearchBar junk
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    filteredShipTypes = SHIP_TYPES.filter({ (ship) -> Bool in
      return ship.lowercaseString.containsString(searchText.lowercaseString)
    })
    if filteredShipTypes.count == 0 {
      searching = false
    } else {
      searching = true
    }
    self.collection.reloadData()
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

