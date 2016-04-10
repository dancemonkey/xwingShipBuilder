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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.cornerRadius = 10.0
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 1.0
    self.layer.shadowOffset = CGSize(width: 3, height: 3)
    self.layer.shadowRadius = 5

  }

  @IBAction func rebelPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Rebel)
  }
  
  @IBAction func imperialPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Imperial)
  }
  
  @IBAction func scumPressed(sender: UIButton) {
    factionSelectDelegate.factionSelected(.Scum)
  }
  
  @IBAction func cancelPressed(sender: UIButton) {
    self.removeFromSuperview()
  }
  
}
