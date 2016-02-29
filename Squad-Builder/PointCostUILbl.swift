//
//  PointCostUILbl.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/23/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class PointCostUILbl: UILabel {
  
  private var _originalPointValue: Int!
  var originalPointValue: Int {
    return _originalPointValue
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    layer.cornerRadius = 5.0
    clipsToBounds = true
    self.font = UIFont(name: "Helvetica Neue", size: 17.0)
    self.textColor = UIColor.darkGrayColor()
    self.backgroundColor = UIColor.lightGrayColor()
    self.layer.borderColor = UIColor.darkGrayColor().CGColor
    self.layer.borderWidth = 2.0
  }
  
  func setOriginalPointValue(withValue value: Int) {
    self._originalPointValue = value
  }

}
