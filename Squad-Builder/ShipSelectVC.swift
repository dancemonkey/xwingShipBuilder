//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: have a button press on an upgrade move to a new VC that shows upgrades you can pick
//TODO: divide ships into factions on ship select VC
//TODO: upgrade buttons on shipdetailVC popup in size when tapped and held
//TODO: ship factions and data pull from JSON, but in dictionary (values must be tied together in order)

import UIKit

class ShipSelectVC: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  let WIDTH: CGFloat = 150
  let HEIGHT: CGFloat = 150
  var SHIP_TITLES = [String]()
  let SHIP_FACTIONS: [String] = ["Scum","Imperial","Rebel"] 
  var selectedShipTitle: String!
  var ships: ShipData!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ships = ShipData()
    SHIP_TITLES = ships.getAllShipTypes()
    print(SHIP_TITLES)
        
    for x in 1...SHIP_TITLES.count {
      scrollView.addSubview(setUpButton(forX: x))
    }
    scrollView.contentSize = CGSize(width: WIDTH * CGFloat(SHIP_TITLES.count), height: scrollView.frame.size.height)
  }
  
  func shipButtonPressed(sender: RoundButton) {
    selectedShipTitle = sender.titleLabel?.text
    performSegueWithIdentifier("showShipDetail", sender: self)
  }

  func setUpButton(forX x: Int) -> RoundButton {
    let button = RoundButton()
    button.setTitle(SHIP_TITLES[x-1], forState: .Normal)
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    button.setBackgroundImage(UIImage(named: SHIP_TITLES[x-1]), forState: .Normal)
    button.frame = CGRect(x: -WIDTH + (WIDTH * CGFloat(x)), y: HEIGHT/2, width: WIDTH, height: HEIGHT)
    button.addTarget(self, action: "shipButtonPressed:", forControlEvents: .TouchUpInside)
    button.awakeFromNib()
    return button
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let destVC = segue.destinationViewController as! ShipDetailVC
    destVC.buttonBackground = selectedShipTitle
    destVC.pilot = PilotCard(ship: selectedShipTitle, pilot: nil)
    destVC.pilotsForShipType = ships.getPilots(selectedShipTitle)
  }
}

