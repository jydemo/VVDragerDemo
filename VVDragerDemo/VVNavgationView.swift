//
//  VVNavgationView.swift
//  VVDragerDemo
//
//  Created by atom on 2017/1/2.
//  Copyright © 2017年 atom. All rights reserved.
//

import UIKit

class VVNavgationView: UIView {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension VVNavgationView {
    
    class func navView() -> VVNavgationView {
        
        return Bundle.main.loadNibNamed("VVNavgationView", owner: self, options: nil)?.first as! VVNavgationView
        
    }

}
