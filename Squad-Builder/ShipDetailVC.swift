//
//  ShipDetailVC.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipDetailVC: UIViewController {

  @IBOutlet weak var shipBtn: RoundButton!
  @IBOutlet weak var pilotBtn: UIButton!
  @IBOutlet weak var pilotLbl: UILabel!
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var upgradeView: UIView!
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var evade: UILabel!
  @IBOutlet weak var hull: UILabel!
  @IBOutlet weak var shield: UILabel!
  
  var buttonBackground: String!
  var pilot: PilotCard!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      shipBtn.awakeFromNib()
      shipBtn.setBackgroundImage(UIImage(named: buttonBackground), forState: .Normal)
      shipBtn.setTitle(pilot.shipType, forState: .Normal)
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}
