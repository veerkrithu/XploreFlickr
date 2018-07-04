//
//  XFListViewCell.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/13/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFListViewCell: UITableViewCell {
    
    private static let kXFListViewCellID = "XFListViewCellID"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var thumbView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
