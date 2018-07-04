//
//  XFRoundImageView.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/14/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFRoundImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = self.frame.width / 2.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(red: 72.0/255.0, green: 122.0/255.0, blue: 244.0/255.0, alpha: 0.8).cgColor
        self.clipsToBounds = true
    }
}
