//
//  RoundImageView.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 2/10/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

  override init(image: UIImage?) {
    super.init(image: image)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = frame.size.width / 2
    clipsToBounds = true
  }

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
}
