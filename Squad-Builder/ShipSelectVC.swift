//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//TODO: next is to have a button press on a ship move to a new VC that shows upgrades you can pick

import UIKit

class ShipSelectVC: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  let WIDTH: CGFloat = 188
  let HEIGHT: CGFloat = 188
  let SHIP_TITLES: [String] = ["Firespray-31","TIE Phantom","T-65 X-Wing"]
  var shipPressedTitle: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for x in 1...3 {
      scrollView.addSubview(setUpButton(forX: x))
    }
    scrollView.contentSize = CGSize(width: WIDTH * 3, height: scrollView.frame.size.height)
  }
  
  func shipButtonPressed(sender: RoundButton) {
    shipPressedTitle = sender.titleLabel?.text      
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
    destVC.buttonBackground = shipPressedTitle
    destVC.pilot = PilotCard(ship: shipPressedTitle, pilot: nil)
  }
}

