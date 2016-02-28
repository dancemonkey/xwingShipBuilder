//
//  ShipUpgradeCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/27/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class ShipUpgradeCell: UITableViewCell {

  @IBOutlet weak var upgradeTitle: UILabel!
  @IBOutlet weak var upgradePointCost: PointCostUILbl!
  @IBOutlet weak var upgradeIcon: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(withUpgrade upgrade: UpgradeCard) {
    upgradeTitle.text = upgrade.name
    upgradePointCost.text = String(upgrade.pointCost)
    upgradeIcon.image = UIImage(named: upgrade.name)
  }

}
