//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipSelectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  @IBOutlet weak var collection: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let WIDTH: CGFloat = 150
  let HEIGHT: CGFloat = 150
  
  var shipTypes = [String]()
  var filteredShipTypes = [String]()
  //let SHIP_FACTIONS: [Faction] = [.Scum, .Rebel, .Imperial]
  var selectedFaction: Faction!
  
  var selectedShipTitle: String!
  var ships: ShipData!
  var squadVC: SquadBuildVC!
  
  var searching = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ships = ShipData()
    shipTypes = ships.getShipsOfFaction(selectedFaction)
    
    collection.delegate = self
    collection.dataSource = self
    
    searchBar.delegate = self
    searchBar.returnKeyType = .Done
    searchBar.setShowsCancelButton(false, animated: false)
  }
  
  @IBAction func cancelPressed(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showShipDetail" {
      let destVC = segue.destinationViewController as! ShipDetailVC
      destVC.pilot = PilotCard(ship: selectedShipTitle, pilot: nil)
      destVC.squadIndex = squadVC.squadron.ships.count
      destVC.squadVC = self.squadVC //!!!: Nope don't like trojan-horsing this data through here to the next stop
    }
  }
  
  // MARK: CollectionView junk
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("shipCell", forIndexPath: indexPath) as? ShipCollectionViewCell {
      if searching {
        cell.configureCell(filteredShipTypes[indexPath.row])
      } else {
        cell.configureCell(shipTypes[indexPath.row])
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
      return shipTypes.count
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 150.0, height: 150.0)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if searching {
      selectedShipTitle = filteredShipTypes[indexPath.row]
    } else {
      selectedShipTitle = shipTypes[indexPath.row]
    }
    performSegueWithIdentifier("showShipDetail", sender: indexPath.row)
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    var header: ShipFactionSectionHeader?
    
    if kind == UICollectionElementKindSectionHeader {
      header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as? ShipFactionSectionHeader
      header?.configureCell(forFaction: selectedFaction.rawValue)
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
      filteredShipTypes = shipTypes.filter({ (ship) -> Bool in
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

