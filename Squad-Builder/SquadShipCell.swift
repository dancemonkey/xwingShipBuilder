//
//  SquadShipCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/11/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class SquadShipCell: UITableViewCell {
  
  @IBOutlet weak var pilotNameLbl: UILabel!
  @IBOutlet weak var pilotUpgradesLbl: UILabel!
  @IBOutlet weak var factionImg: UIImageView!
  @IBOutlet weak var pointCostLbl: UILabel!

  func configureCell(withPilot pilot: PilotCard) {
    self.pilotNameLbl.text = pilot.pilotName
    var upgrades = ""
    for upgrade in pilot.currentUpgrades {
      upgrades += upgrade.name + "..."
    }
    self.pilotUpgradesLbl.text = upgrades
    self.factionImg.image = UIImage(imageLiteral: "\(pilot.faction)")
    self.pointCostLbl.text = "\(pilot.currentPointCost)"
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
