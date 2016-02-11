//
//  RoundButton.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    layer.cornerRadius = frame.size.width / 2
    clipsToBounds = true
  }

}
