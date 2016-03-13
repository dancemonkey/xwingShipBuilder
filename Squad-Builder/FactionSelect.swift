//
//  FactionSelect.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

protocol FactionSelectDelegate {
  func factionSelected(faction: Faction)
}

import UIKit

class FactionSelect: UIView {
  
  var factionSelectDelegate: FactionSelectDelegate!

  @IBAction func rebelPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Rebel)
  }
  
  @IBAction func imperialPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Imperial)
  }
  
  @IBAction func scumPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Scum)
  }
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
