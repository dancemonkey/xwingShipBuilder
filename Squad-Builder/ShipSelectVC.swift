//
//  ViewController.swift
//  Squad-Builder
//
//  Created by Drew Lanning on 1/29/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

//!!!: just playing around with an interface to keep my interest going
//TODO: next is to have a button press on a ship move to a new VC that shows upgrades you can pick

import UIKit

class ShipSelectVC: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  let WIDTH: CGFloat = 188
  let HEIGHT: CGFloat = 188
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for x in 1...3 {
      let img = UIImage(named: "\(x)")
      let button = RoundButton()
      button.setImage(img, forState: .Normal)
      scrollView.addSubview(button)
      button.frame = CGRect(x: -WIDTH + (WIDTH * CGFloat(x)), y: HEIGHT/2, width: WIDTH, height: HEIGHT)
      button.awakeFromNib()
    }
    scrollView.contentSize = CGSize(width: WIDTH * 3, height: scrollView.frame.size.height)
  }

}

