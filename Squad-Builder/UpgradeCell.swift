//
//  UpgradeCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/27/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class UpgradeCell: UITableViewCell {
  
  @IBOutlet weak var upgradeIcon: UIImageView!
  @IBOutlet weak var upgradeTitle: UILabel!
  @IBOutlet weak var upgradeText: UILabel!
  @IBOutlet weak var upgradeCost: PointCostUILbl!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(withUpgrade upgrade: UpgradeCard) {
    upgradeIcon.image = UIImage(named: upgrade.type.rawValue)
    upgradeTitle.text = upgrade.name
    upgradeText.text = upgrade.text
    upgradeText.sizeToFit()
    upgradeCost.text = String(upgrade.pointCost)
  }

}
