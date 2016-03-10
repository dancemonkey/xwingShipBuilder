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
//TODO: need squad creation screen that leads to ship select screen, etc.

import UIKit

class ShipSelectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let WIDTH: CGFloat = 150
  let HEIGHT: CGFloat = 150
  
  var SHIP_TYPES = [[String]]()
  var ALL_SHIPS = [String]()
  var filteredShipTypes = [String]()
  let SHIP_FACTIONS: [Faction] = [.Scum, .Rebel, .Imperial]
  
  var selectedShipTitle: String!
  var ships: ShipData!
  
  var searching = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ships = ShipData()
    for faction in SHIP_FACTIONS {
      SHIP_TYPES.append(ships.getShipsOfFaction(faction))
    }
    print(SHIP_TYPES)
    ALL_SHIPS = ships.getAllShipTypes()
    
    collection.delegate = self
    collection.dataSource = self
    
    searchBar.delegate = self
    searchBar.returnKeyType = .Done
    searchBar.setShowsCancelButton(false, animated: false)
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
        cell.configureCell(SHIP_TYPES[indexPath.section][indexPath.row])
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
      return SHIP_TYPES[section].count
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 150.0, height: 150.0)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    if searching {
      return 1
    } else {
      return SHIP_FACTIONS.count
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if searching {
      selectedShipTitle = filteredShipTypes[indexPath.row]
    } else {
      selectedShipTitle = SHIP_TYPES[indexPath.section][indexPath.row]
    }
    performSegueWithIdentifier("showShipDetail", sender: self)
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    var header: ShipFactionSectionHeader?
    
    if kind == UICollectionElementKindSectionHeader {
      header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as? ShipFactionSectionHeader
      header?.configureCell(forFaction: SHIP_FACTIONS[indexPath.section].rawValue)
    }
    if searching {
      header?.factionImg.hidden = true
    } else if !searching {
      header?.factionImg.hidden = false
    }
    return header!
  }
  
  // MARK: SearchBar junk
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text == nil || searchBar.text == "" {
      searching = false
      view.endEditing(true)
      self.collection.reloadData()
    } else {
      searching = true
      filteredShipTypes = ALL_SHIPS.filter({ (ship) -> Bool in
        return ship.lowercaseString.containsString(searchText.lowercaseString)
      })
      self.collection.reloadData()
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
    self.collection.reloadData()
    view.endEditing(true)
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    view.endEditing(true)
    searching = false
  }
  
}

