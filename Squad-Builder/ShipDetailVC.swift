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
  var buttonBackground: String!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      shipBtn.awakeFromNib()
      shipBtn.setBackgroundImage(UIImage(named: buttonBackground), forState: .Normal)
      shipBtn.setTitle(buttonBackground, forState: .Normal)
    }
  
  @IBAction func cancelPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}
