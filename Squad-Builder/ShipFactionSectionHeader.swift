//
//  ShipFactionSectionHeader.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/9/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipFactionSectionHeader: UICollectionReusableView {
  @IBOutlet weak var factionImg: UIImageView!
  
  func configureCell(forFaction faction: String) {
    factionImg.image = UIImage(named: faction)
  }
}