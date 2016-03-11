//
//  SquadronCell.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 3/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class SquadronCell: UITableViewCell {

  @IBOutlet weak var factionImg: UIImageView!
  @IBOutlet weak var pointCost: PointCostUILbl!
  @IBOutlet weak var squadDesc: UILabel!
  @IBOutlet weak var squadName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configureCell(withSquadron squadron: Squadron) {
    self.pointCost.text = "\(squadron.pointCost)"
    self.squadName.text = squadron.name
    self.factionImg.image = UIImage(named: squadron.faction.rawValue)
    var descText = ""
    for ship in squadron.ships {
      descText += ship.pilotName! + " "
    }
    self.squadDesc.text = descText
  }

}
