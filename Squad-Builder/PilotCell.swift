//
//  PilotCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/4/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class PilotCell: UITableViewCell {

  @IBOutlet weak var pilotName: UILabel!
  @IBOutlet weak var pointCost: PointCostUILbl!
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var agility: UILabel!
  @IBOutlet weak var shield: UILabel!
  @IBOutlet weak var hull: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configureCell(withPilot pilot: PilotCard) {
    self.pilotName.text = pilot.pilotName!
    self.pointCost.text = String(pilot.startingPointCost)
    self.attack.text = String(pilot.shipStats.attack)
    self.agility.text = String(pilot.shipStats.agility)
    self.shield.text = String(pilot.shipStats.shield)
    self.hull.text = String(pilot.shipStats.hull)
  }
}
