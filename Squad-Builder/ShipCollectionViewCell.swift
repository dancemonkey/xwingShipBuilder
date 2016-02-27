//
//  ShipCollectionViewCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/26/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var shipName: UILabel!
  @IBOutlet weak var shipImg: RoundImageView!
  
  func configureCell(shipName: String) {
    self.shipName.text = shipName
    self.shipImg.image = UIImage(named: shipName)
  }
}
